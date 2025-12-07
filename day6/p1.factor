USING: combinators io kernel math.matrices math.parser prettyprint sequences splitting ;
IN: main

: parse-input-line ( inp -- res )
  " " split [ empty? ] reject ;
  
: process-problem ( problem -- result )
  dup last swap 1 head*
  [ string>number ] map
  swap {
    { "*" [ product ] }
    { "+" [ sum ] }
  } case ;
  
: main ( -- )
  read-lines
  [ parse-input-line ] map
  flip
  [ process-problem ] map
  sum
  number>string
  print ;

main