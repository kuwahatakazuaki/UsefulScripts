#!/bin/bash

function get_disOO() {
grep -A9  "POSITION" OUTCAR |tail -2 |
  awk '
    BEGIN{i=1} {x[i]=$1; y[i]=$2; z[i]=$3; i=i+1} 
    END{
     # for (j=1;j<=2;j++) print j, x[j], y[j], z[j]
      dx = x[1]-x[2]; dy = y[1]-y[2]; dz = z[1]-z[2]
     # print dx, dy, dz
      print sqrt(dx*dx + dy*dy + dz*dz)
    }
    '
}

Dist=$(get_disOO)
Free=$(grep "free  energy   TOTEN" OUTCAR |tail -1 |awk '{print $5}')
Latt=$(grep -A1  "length of vectors" OUTCAR |tail -1|awk '{print $1 "\n" $2 "\n" $3}')
Volu=$(grep "volume of cell" OUTCAR |tail -1 |awk '{print $5}')


echo "Free Dist Volu Latt"
echo $Free
echo $Dist
echo $Volu
echo $Latt |tr " " "\n"

