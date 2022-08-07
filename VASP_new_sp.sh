#!/bin/bash

all_file="INCAR  KPOINTS  POSCAR  POTCAR"
dir_new="sp_new"
system=$(grep "SYSTEM" INCAR | awk '{print $3}')

if [ ! -d $dir_new ]; then
  mkdir $dir_new
fi

for file in $(echo $all_file);
do
  cp $file $dir_new
done

tac XDATCAR |sed "/${system}/q" | tac > $dir_new/POSCAR 

cd $dir_new
sed '/IBRION/d' INCAR > tempfile
sed '/NSW/d' tempfile > INCAR 

rm tempfile

# /home/vasp_guest/.local/vasp.5.4.4.intel_serial/bin/vasp_std > log.out &

