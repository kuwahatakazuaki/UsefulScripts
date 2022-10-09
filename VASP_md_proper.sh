#!/bin/bash

out1='temperature.out'
out2='volume.out'
out3='md.out'

grep " T=" OSZICAR |awk '{print $1, $3, $5}' > $out1
grep "volume" vasprun.xml |sed '1,3d' |awk '{print $3}' > $out2

paste -d " " $out1 $out2 > $out3

rm $out1 $out2


