#!/bin/bash
cities="$(<cities.list)"
IFS=$'\n' && cities=( ${cities} )
lines=$(cat cities.list|wc -l)
counter=0
for i in ${cities[@]}
do
  if [ $(echo "$counter") -lt $(echo "$(($lines-1))") ]
    then
      echo ${i}';'
    else
      echo ${i}
  fi
  let "counter=counter+1"
done
