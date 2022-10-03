#!/bin/bash

grep " T=" OSZICAR |awk '{print $1, $3, $5}' > temperature.out
grep "volume" vasprun.xml |awk '{print $3}' > volume.out

