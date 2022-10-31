#!/bin/bash
vasp_exe="/home/vasp_guest/.local/vasp.5.4.4.intel_serial/bin/vasp_std"

if [ -e nohup.out ]; then
  : > nohup.out
fi

fileAll="INCAR  KPOINTS  POSCAR  POTCAR"
echo "# val1  Efre Time" > data.out
: > data.tmp

# num=0
#for val1 in $(seq 0.9  0.1   1.2  ); do
for val1 in {1..8}; do

{
  echo -n "Calculating $val1 : "
  input="input/"
  # num=$((num+1))
  # dir="run$(printf "%03d" $num)"
  dir="dir${val1}"
  cp -r $input $dir
  cd $dir

    sed -e "s/val1/$val1/g" temp > KPOINTS

    $vasp_exe > log.out

    if grep -q "General timing and accounting" OUTCAR ; then
      echo "Normal termination"
      Efre=$(grep "free  energy   TOTEN" OUTCAR |tail -1|awk '{print $5}')
      #Edif=$(grep "EDIFF" OUTCAR |head -1|awk '{print $3}')
      Time=$(grep "Total CPU time used" OUTCAR |awk '{print $6}')
    else
      Efre=" Error"
    fi

  cd ..
  echo "$val1 $Efre $Time" >> data.tmp
}
done

wait
sort data.tmp >> data.out
rm data.tmp

echo "Normal termination"


