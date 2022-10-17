#!/bin/bash

sed -i -e 's/H   /H    1.0078 /' $1
sed -i -e 's/D   /H    2.0141 /' $1
sed -i -e 's/Li  /Li   6.0151 /' $1
sed -i -e 's/C   /C   12.0000 /' $1
sed -i -e 's/N   /N   14.0030 /' $1
sed -i -e 's/O   /O   15.9949 /' $1
sed -i -e 's/F   /F   18.9984 /' $1
sed -i -e 's/Si  /Si  27.9769 /' $1
sed -i -e 's/P   /P   30.9738 /' $1
sed -i -e 's/Pb  /Pb 203.9730 /' $1

