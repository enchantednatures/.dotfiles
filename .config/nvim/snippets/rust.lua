local ls = require "luasnip"
local s = ls.snippet
local d = ls.dynamic_node
local t = ls.text_node
local i = ls.insert_node
local t = ls.text_node
local sn = ls.snippet_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local function has_import(import_name)
  local parser = vim.treesitter.get_parser(0)
  local tree = parser:parse()[1]
  local root = tree:root()

  local query = vim.treesitter.query.parse(
    "rust",
    [[
      (use_declaration
        [(scoped_use_list
          (use_list
            (identifier) @import))
          (scoped_identifier
            (_) @namespace
            (identifier) @import)]) @use
    ]]
  )

  for id, node, metadata in query:iter_captures(root, 0) do
    local name = vim.treesitter.get_node_text(node, 0)
    if name == import_name then return true end
  end
  return false
end

vim.api.nvim_create_user_command("HasImport", function(opts)
  local has = has_import(opts.args)
  vim.notify("Has import " .. opts.args .. ": " .. tostring(has))
end, {
  nargs = 1,
  desc = "Check if a specific import is present in the current buffer",
})

local get_test_result = function(position)
  return d(position, function()
    local nodes = {}
    table.insert(nodes, t "") -- Start with an empty option

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local found_anyhow = false
    for _, line in ipairs(lines) do
      if line:match "anyhow::Result" then
        found_anyhow = true
        break
      end
    end

    if found_anyhow then
      table.insert(nodes, t " -> Result<()> ")
    else
      table.insert(nodes, t " -> Result<(),()>")
    end

    table.insert(nodes, t "something")
    table.insert(nodes, t "final")

    return sn(nil, c(1, nodes))
  end, {})
end

return {

  -- Debug format
  s("debug", { t "{:#?}" }),
  -- print the contents of a variable
  s("print", fmt([[ println!("{} = {{:#?}}", &{}); ]], { i(1, "variable_name"), rep(1) })),
  -- implement display for a type
  s(
    "impldisplay",
    fmt(
      [[
                        impl fmt::Display for {} {{
                            fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {{
                                write!(f, "{}", {})
                            }}
                        }}
                        ]],
      {
        i(1, "type"),
        i(2),
        i(0),
      }
    )
  ),
  -- adding a test case
  s(
    "testresult",
    fmt(
      [[
                        #[test]
                        fn {}(){}{{
                            {}
                        }}
                        ]],
      {
        i(1, "testname"),
        get_test_result(2),
        i(0),
      }
    )
  ),
  s("collectvec", {
    t { ".collect::<Vec<_>>()" },
  }),
  -- adding a test module
  s(
    "modtest",
    fmt(
      [[
                        #[cfg(test)]
                        mod test {{
                        {}

                            {}
                        }}
                        ]],
      {
        c(1, { t "    use super::*;", t "" }),
        i(0),
      }
    )
  ),
  -- populate a mod.rs file
  s(
    "mod.rs",
    fmt(
      [[
                        mod {};

                        pub use {}::*;
                        ]],
      { i(1, "<name of the rust file in this module>"), rep(1) }
    )
  ),
  s("rustfmt", t "#[rustfmt::skip]"),
  s("deadcode", t "#[allow(dead_code)]"),
  s("ddbg", t "#[derive(Debug)]"),
  s("ddds", t "#[derive(Debug, serde::Serialize, serde::Deserialize)]"),
  s("clippypedantic", t "#![warn(clippy::all, clippy::pedantic)]"),
  s(":turbofish", { t { "::<" }, i(1), t { ">" }, i(2) }),

  -- SQLx related snippets
  s(
    "sqlxquery",
    fmt(
      [[
    let {} = sqlx::query_as!(
        {},
        r#"
            {}
        "#,
        {}
    )
    .{}
    {}
    .await?;
  ]],
      {
        i(1, "entity"),
        i(2, "Record"),
        i(3, "SELECT * FROM table"),
        i(4),
        c(5, {
          t "fetch_all(&self.pool)",
          t "fetch_optional(&self.pool)",
          t "fetch_one(&self.pool)",
        }),
        d(6, function(args)
          if has_import "Instrument" then
            return sn(nil, {
              c(1, {
                fmt('\n.instrument(tracing::info_span!("{}")))', {
                  i(1, "db_query"),
                }),
                t "", -- No newline for empty choice
              }),
            })
          else
            return sn(nil, { t "" })
          end
        end, { 1 }),
      }
    )
  ),
  s(
    "sqlxtx",
    fmt(
      [[
    let mut tx = self.pool.begin().await?;
    {}
    tx.commit().await?;
  ]],
      {
        i(1),
      }
    )
  ),

  -- Axum related snippets
  s(
    "axrouter",
    fmt(
      [[
    pub fn router() -> Router {{
        Router::new()
            {}
            .layer(TraceLayer::new_for_http())
            .layer(cors)
            .layer(CompressionLayer::new())
    }}
  ]],
      {
        i(1, '.route("/health", get(health_check))'),
      }
    )
  ),

  s(
    "axhandler",
    fmt(
      [[
    pub async fn {}(
        State(state): State<Arc<{}>>,
        {}
    ) -> Result<impl IntoResponse, AppError> {{
        {}
    }}
  ]],
      {
        i(1, "handler_name"),
        i(2, "AppState"),
        c(3, {
          t "Json(payload): Json<Request>",
          t "Path(id): Path<String>",
          t "Query(params): Query<Params>",
          t "",
        }),
        i(4),
      }
    )
  ),

  -- Kafka related snippets
  s(
    "kafkaprod",
    fmt(
      [[
    let producer: FutureProducer = ClientConfig::new()
        .set("bootstrap.servers", "{}")
        .set("message.timeout.ms", "5000")
        .create()
        .expect("Producer creation failed");
  ]],
      {
        i(1, "localhost:9092"),
      }
    )
  ),

  s(
    "kafkacons",
    fmt(
      [[
    let consumer: StreamConsumer = ClientConfig::new()
        .set("group.id", "{}")
        .set("bootstrap.servers", "{}")
        .set("enable.partition.eof", "false")
        .set("session.timeout.ms", "6000")
        .set("enable.auto.commit", "true")
        .create()?;

    consumer.subscribe(&[{}])?;
  ]],
      {
        i(1, "my-group"),
        i(2, "localhost:9092"),
        i(3, '"my-topic"'),
      }
    )
  ),

  -- Tracing/OpenTelemetry snippets
  s(
    "traceinit",
    fmt(
      [[
    let tracer = opentelemetry_otlp::new_pipeline()
        .tracing()
        .with_exporter(opentelemetry_otlp::new_exporter()
            .tonic()
            .with_endpoint("{}")
        )
        .with_trace_config(
            trace::config()
                .with_sampler(Sampler::AlwaysOn)
                .with_resource(Resource::new(vec![KeyValue::new(
                    "service.name",
                    "{}",
                )]))
        )
        .install_batch(opentelemetry::runtime::Tokio)?;

    tracing_subscriber::registry()
        .with(tracing_subscriber::EnvFilter::from_default_env())
        .with(tracing_subscriber::fmt::layer())
        .with(tracing_opentelemetry::layer().with_tracer(tracer))
        .init();
  ]],
      {
        i(1, "http://otel-collector:4317"),
        i(2, "my-service"),
      }
    )
  ),

  s(
    "tracefn",
    fmt(
      [[
    #[instrument(skip({}))]
    pub async fn {}({}) -> Result<{}, {}> {{
        {}
    }}
  ]],
      {
        i(1, "self"),
        i(2, "function_name"),
        i(3, "param: Type"),
        i(4, "ReturnType"),
        i(5, "Error"),
        i(6),
      }
    )
  ),

  -- Kubernetes/Config related snippets
  s(
    "cfgload",
    fmt(
      [[
    #[derive(Debug, Serialize, Deserialize)]
    pub struct Config {{
        {}
    }}

    impl Config {{
        pub fn load() -> Result<Self, ConfigError> {{
            let env = std::env::var("APP_ENV").unwrap_or_else(|_| "development".to_string());
            let c = config::Config::builder()
                .add_source(config::File::with_name("config/default"))
                .add_source(config::File::with_name(&format!("config/{{}}", env)).required(false))
                .add_source(config::Environment::with_prefix("APP").separator("_"))
                .build()?;

            c.try_deserialize()
        }}
    }}
  ]],
      {
        i(
          1,
          [[
        pub database_url: String,
        pub kafka_brokers: Vec<String>,
        pub otel_endpoint: String,
    ]]
        ),
      }
    )
  ),

  -- Error handling snippets
  s(
    "errortype",
    fmt(
      [[
    #[derive(Debug, thiserror::Error)]
    pub enum {} {{
        #[error("Database error: {{0}}")]
        Database(#[from] sqlx::Error),

        #[error("Validation error: {{0}}")]
        Validation(String),

        #[error("Not found: {{0}}")]
        NotFound(String),

        #[error(transparent)]
        Other(#[from] anyhow::Error),
    }}
  ]],
      {
        i(1, "AppError"),
      }
    )
  ),

  -- Common development patterns
  s(
    "newtype",
    fmt(
      [[
    #[derive(Debug, Clone, Eq, PartialEq, Hash)]
    pub struct {}(pub {});
  ]],
      {
        i(1, "Type"),
        i(2, "String"),
      }
    )
  ),

  s(
    "testmod",
    fmt(
      [[
    #[cfg(test)]
    mod tests {{
        use super::*;
        use test_context::test_context;
        use pretty_assertions::assert_eq;

        struct TestContext {{
            {}
        }}

        #[test_context(TestContext)]
        #[tokio::test]
        async fn test_{}(ctx: &mut TestContext) {{
            {}
        }}
    }}
  ]],
      {
        i(1, "client: Client,"),
        i(2, "name"),
        i(3),
      }
    )
  ),
}
