#!/bin/bash

for num in {1..4}; do
  echo ""
  echo "kavalan0${num}"
  ssh kavalan0${num} who
  ssh kavalan0${num} sar |  (head -4|tail -1; tail -2|head -1)
done


#  ssh kavalan0${num} sar |  (head -4|tail -1; tail -2|head -1)
#  ssh kavalan0${num} sar |head -4|tail -1
#  ssh kavalan0${num} sar |tail -2|head -1

