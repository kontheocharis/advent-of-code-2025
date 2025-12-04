

input=$(cat)

total=0

for i in $input; do
  ichars=$(echo $i | grep -o .)
  inumchars=$(echo $i | wc -c)
  
  N=12

  highest=( $(for ((i=0; i<N; i++)); do echo "-1"; done) )

  highestIdx=-1

  for ((arrayIdx=0; arrayIdx<N; arrayIdx++)); do
    currIdx=0
    for c in $ichars; do
      if (($currIdx <= $highestIdx)); then
        currIdx=$(($currIdx + 1));
        continue;
      fi

      if (($currIdx + ($N - $arrayIdx) == $inumchars)); then
        break
      fi
      if (( $c > ${highest[$arrayIdx]} )); then
        highestIdx=$currIdx
        highest[$arrayIdx]=$c
      fi
      currIdx=$(($currIdx + 1));
    done;
  done

    
  
  together=$(IFS=""; echo "${highest[*]}")
  total=$(($total + $together))

done;

echo $total