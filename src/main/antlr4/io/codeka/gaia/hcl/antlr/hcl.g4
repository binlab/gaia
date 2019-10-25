grammar hcl;

file
  : directive+
  ;

directive
  : variableDirective
  | outputDirective
  ;

variableDirective
  : 'variable' identifier variableBlock
  ;

variableBlock
  : '{' type? variableDescription? r_default? '}'
  ;

outputDirective
  : 'output' identifier outputBlock
  ;

outputBlock
  : '{' outputValue? outputDescription? sensitive? '}'
  ;

outputValue
  : 'value' '=' expression
  ;

outputDescription
  : 'description' '=' STRING
  ;

sensitive
  : 'sensitive' '=' BOOLEAN
  ;

type
  : 'type' '=' TYPE
  ;

variableDescription
  : 'description' '=' STRING
  ;

r_default
  : 'default' '=' expression
  ;

expression
  : STRING
  | NUMBER
  | BOOLEAN
  | UNQUOTED_STRING
  ;

identifier
  : STRING
  ;

BOOLEAN
  : 'true'
  | '"true"'
  | 'false'
  | '"false"'
  ;

TYPE
  : 'string'
  | '"string"'
  | 'number'
  | '"number"'
  | 'bool'
  | '"bool"'
  ;

UNQUOTED_STRING
  : [a-zA-Z0-9_.[\]-]+
  ;

/**
 * STRING Lexer Rule comes from the JSON grammar
 * https://github.com/antlr/grammars-v4/blob/master/json/JSON.g4
 */
STRING
   : '"' (ESC | SAFECODEPOINT)* '"'
   ;

fragment ESC
   : '\\' (["\\/bfnrt] | UNICODE)
   ;
fragment UNICODE
   : 'u' HEX HEX HEX HEX
   ;
fragment HEX
   : [0-9a-fA-F]
   ;
fragment SAFECODEPOINT
   : ~ ["\\\u0000-\u001F]
   ;

NUMBER
   : '0' | [1-9] [0-9]*
   ;

WS
  : [ \t\r\n]+ -> skip
  ; // skip spaces, tabs, newlines
