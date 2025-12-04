

input=$(cat)

total=0

for i in $input; do
  ichars=$(echo $i | grep -o .)
  inumchars=$(echo $i | wc -c)

  highest=-1
  highestIdx=-1
  currIdx=0

  for c in $ichars; do
    if (($currIdx + 2 == $inumchars)); then
      break
    fi
    if (( $c > $highest )); then
      highestIdx=$currIdx
      highest=$c
    fi
    currIdx=$(($currIdx + 1));
  done

  remainingNum=$(($inumchars - ($highestIdx - 1))) 
  nextHighest=-1
  currIdx=0
  for c in $(echo $ichars | tail -n 3); do
    if (($currIdx <= $highestIdx)); then
      currIdx=$(($currIdx + 1));
      continue;
    fi
    if (( $c > $nextHighest )); then
      nextHighest=$c
    fi;
  done
    
  together="$highest""$nextHighest"
  total=$(($total + $together))

done;

echo $total