USING: ascii combinators io io.encodings.string
io.encodings.utf8 kernel math.matrices math.parser prettyprint
sequences splitting strings ;
IN: main

: process-line ( l -- n )
  dup
  first
  last
  1string
  swap
  [ [ digit? ] filter string>number ] map
  swap {
    { "*" [ product ] }
    { "+" [ sum ] }
  } case ;
  
: main ( -- )
  read-lines
  flip
  [ utf8 decode ] map
  [ [ blank? ] all? ] split-when
  [ process-line ] map
  sum
  number>string
  print ;

main