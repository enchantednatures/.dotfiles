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
  -- Class definitions
  s("class", {
    t "public class ",
    i(1, "ClassName"),
    t " {",
    t { "", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("record", {
    t "public record ",
    i(1, "RecordName"),
    t "(",
    i(2),
    t ");",
  }),

  s("abstract", {
    t "public abstract class ",
    i(1, "AbstractClassName"),
    t " {",
    t { "", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("sealed", {
    t "public sealed class ",
    i(1, "SealedClassName"),
    t " {",
    t { "", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("static", {
    t "public static class ",
    i(1, "StaticClassName"),
    t " {",
    t { "", "\t" },
    i(0),
    t { "", "}" },
  }),

  -- Properties
  s("prop", {
    t "public ",
    i(1, "int"),
    t " ",
    i(2, "PropertyName"),
    t " { get; set; }",
  }),

  s("propg", {
    t "public ",
    i(1, "int"),
    t " ",
    i(2, "PropertyName"),
    t " { get; }",
  }),

  s("propi", {
    t "public ",
    i(1, "int"),
    t " ",
    i(2, "PropertyName"),
    t " { get; init; }",
  }),

  s("propn", {
    t "public ",
    i(1, "string"),
    t "? ",
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
    t { "", "\tget => _" },
    rep(2),
    t ";",
    t { "", "\tset => _" },
    rep(2),
    t " = value;",
    t { "", "}" },
  }),

  -- Methods
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

  s("async", {
    t "public async Task",
    c(1, { t "", t "<", i(1, "T"), t ">" }),
    t " ",
    i(2, "MethodName"),
    t "(",
    i(3),
    t ")",
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("override", {
    t "public override ",
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

  s("virtual", {
    t "public virtual ",
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

  -- Constructors
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

  s("sctor", {
    t "static ",
    i(1, "ClassName"),
    t "()",
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  -- Interfaces
  s("interface", {
    t "public interface I",
    i(1, "InterfaceName"),
    t " {",
    t { "", "\t" },
    i(0),
    t { "", "}" },
  }),

  -- Control flow
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

  s("for", {
    t "for (int ",
    i(1, "i"),
    t " = 0; ",
    rep(1),
    t " < ",
    i(2, "length"),
    t "; ",
    rep(1),
    t "++)",
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("while", {
    t "while (",
    i(1, "condition"),
    t ")",
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("do", {
    t "do",
    t { "", "{", "\t" },
    i(0),
    t { "", "} while (" },
    i(1, "condition"),
    t ");",
  }),

  s("switch", {
    t "switch (",
    i(1, "variable"),
    t ")",
    t { "", "{" },
    t { "", "\tcase " },
    i(2, "value"),
    t ":",
    t { "", "\t\t" },
    i(3),
    t { "", "\t\tbreak;" },
    t { "", "\tdefault:" },
    t { "", "\t\t" },
    i(0),
    t { "", "\t\tbreak;" },
    t { "", "}" },
  }),

  s("if", {
    t "if (",
    i(1, "condition"),
    t ")",
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("else", {
    t "else",
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("elif", {
    t "else if (",
    i(1, "condition"),
    t ")",
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  -- Exception handling
  s("try", {
    t "try",
    t { "", "{", "\t" },
    i(1),
    t { "", "}" },
    t { "", "catch (" },
    i(2, "Exception"),
    t " ",
    i(3, "ex"),
    t ")",
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("finally", {
    t "finally",
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("using", {
    t "using (",
    i(1, "var resource = new Resource()"),
    t ")",
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  -- LINQ and Collections
  s("linq", {
    i(1, "collection"),
    t ".",
    c(2, {
      t "Where(x => ",
      t "Select(x => ",
      t "FirstOrDefault(x => ",
      t "Any(x => ",
      t "All(x => ",
      t "Count(x => ",
    }),
    i(3, "condition"),
    t ")",
    c(4, { t "", t ".", i(1) }),
  }),

  -- Attributes and Annotations
  s("attr", {
    t "[",
    i(1, "AttributeName"),
    c(2, { t "", t "(", i(1), t ")" }),
    t "]",
  }),

  -- Testing (NUnit/xUnit)
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

  s("fact", {
    t "[Fact]",
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

  s("theory", {
    t "[Theory]",
    t { "", "[InlineData(" },
    i(1, "testData"),
    t ")]",
    t { "", "public void " },
    i(2, "TestName"),
    t "(",
    i(3, "parameters"),
    t ")",
    t { "", "{", "\t// Arrange", "\t" },
    i(4),
    t { "", "", "\t// Act", "\t" },
    i(5),
    t { "", "", "\t// Assert", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("setup", {
    t "[SetUp]",
    t { "", "public void SetUp()" },
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("teardown", {
    t "[TearDown]",
    t { "", "public void TearDown()" },
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  -- Async/Await patterns
  s("await", {
    t "await ",
    i(1, "asyncMethod"),
    t "();",
  }),

  s("task", {
    t "Task.Run(() => ",
    i(1),
    t ");",
  }),

  s("configureawait", {
    t "await ",
    i(1, "asyncMethod"),
    t "().ConfigureAwait(false);",
  }),

  -- Common patterns
  s("singleton", {
    t "private static readonly Lazy<",
    i(1, "ClassName"),
    t "> _instance = new(() => new ",
    rep(1),
    t "());",
    t { "", "public static " },
    rep(1),
    t " Instance => _instance.Value;",
  }),

  s("dispose", {
    t "public void Dispose()",
    t { "", "{", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("equals", {
    t "public override bool Equals(object? obj)",
    t { "", "{", "\treturn obj is " },
    i(1, "ClassName"),
    t " other && ",
    i(2, "comparison"),
    t ";",
    t { "", "}" },
  }),

  s("gethashcode", {
    t "public override int GetHashCode()",
    t { "", "{", "\treturn HashCode.Combine(" },
    i(1, "properties"),
    t ");",
    t { "", "}" },
  }),

  s("tostring", {
    t "public override string ToString()",
    t { "", "{", '\treturn $"' },
    i(1, "format"),
    t '";',
    t { "", "}" },
  }),

  -- Nullable reference types
  s("nullable", {
    i(1, "string"),
    t "? ",
    i(2, "variableName"),
    t " = ",
    i(3, "null"),
    t ";",
  }),

  s("notnull", {
    i(1, "ArgumentNullException"),
    t ".ThrowIfNull(",
    i(2, "parameter"),
    t ");",
  }),
}
