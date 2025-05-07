; Keywords
(keyword_operation) @keyword       
(keyword_operator) @keyword.operator 
(keyword_traversal) @keyword.operator 
(traversal_direction) @keyword.special 
(sort_direction) @attribute
(keyword_distinct) @type.qualifier


; Literals
(string) @string
(escape_sequence) @string.escape
(number) @number
(boolean_literal) @boolean
(null_literal) @constant.builtin

; Identifiers and Variables
(identifier) @variable
; Function calls
(function_call
  function_name: (identifier) @function)

; Collection names
; (collection_selector
;   (collection_name
;     (identifier) @type))

; Bind variables (both types)
(bind_parameter) @variable.parameter
(collection_bind_parameter) @variable.parameter

; Graph traversal syntax
(depth_range) @number
(for_traversal_operation
  variables: (identifier) @variable.parameter)

; Object properties
(object_pair
  key: (property_identifier) @property)
(object_pair
  key: (string) @property)
(shorthand_property_identifier) @property

; Member access
(member_expression
  property: (identifier) @property)

; Wildcards
"*" @operator

; Operators
(comparison_operator) @operator

; Punctuation
"." @punctuation.delimiter
".." @punctuation.special
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket
"(" @punctuation.bracket
")" @punctuation.bracket
":" @punctuation.delimiter
"," @punctuation.delimiter

; Comments
(comment) @comment
