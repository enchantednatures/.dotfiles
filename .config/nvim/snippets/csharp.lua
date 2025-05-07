local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local rep = require("luasnip.extras").rep

return {
  s("class", {
    t "public class ",
    i(1, "ClassName"),
    t " {",
    t { "", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("prop", {
    t "public ",
    i(1, "int"),
    t " ",
    i(2, "PropertyName"),
    t " { get; set; }",
  }),

  s("propfull", {
    t "private ",
    i(1, "int"),
    t " _",
    i(2, "propertyName"),
    t ";",
    t { "", "" },
    t "public ",
    rep(1),
    t " ",
    i(3, "PropertyName"),
    t " {",
    t { "", "\tget { return _" },
    rep(2),
    t "; }",
    t { "", "\tset { _" },
    rep(2),
    t " = value; }",
    t { "", "}" },
  }),

  s("ctor", {
    t "public ",
    i(1, "ClassName"),
    t "(",
    i(2),
    t ")",
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("smethod", {
    t "public static ",
    i(1, "void"),
    t " ",
    i(2, "MethodName"),
    t "(",
    i(3),
    t ")",
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("method", {
    t "public ",
    i(1, "void"),
    t " ",
    i(2, "MethodName"),
    t "(",
    i(3),
    t ")",
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("foreach", {
    t "foreach (var ",
    i(1, "item"),
    t " in ",
    i(2, "collection"),
    t ")",
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("interface", {
    t "public interface I",
    i(1, "InterfaceName"),
    t " {",
    t { "", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("test", {
    t "[Test]",
    t { "", "public void " },
    i(1, "TestName"),
    t "_",
    i(2, "Condition"),
    t "_",
    i(3, "ExpectedResult"),
    t "()",
    t { "", "{", "\t// Arrange", "\t" },
    i(4),
    t { "", "", "\t// Act", "\t" },
    i(5),
    t { "", "", "\t// Assert", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("testsetup", {
    t "public class ",
    i(1, "TestClassName"),
    t { "", "{", "" },
    t "\t[Test]",
    t { "", "\tpublic void " },
    i(2, "TestName"),
    t "()",
    t { "", "\t{", "\t\t// Arrange", "\t\t" },
    i(3),
    t { "", "", "\t\t// Act", "\t\t" },
    i(4),
    t { "", "", "\t\t// Assert", "\t\t" },
    i(0),
    t { "", "\t}", "", "}" },
  }),
}
