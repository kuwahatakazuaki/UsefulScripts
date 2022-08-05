#/bin/bash

if [ "$1" == "" ]; then
  echo "No Argument"
  if [ ! -e ./"1.com" ]; then
    echo "Writing 1.com"
    file="1.com"
  else
    echo "1.com exist. Write other name"
    exit
  fi
else
  file="$1"
fi


touch $file
cat << EOS > $file
%Nproc=1
%Mem=1Gb
# B3LYP/6-31G
opt

comment

0 1
O
H 1 R1
H 1 R1 2 A1

R1 1.0
A1 120.0

EOS




