#!/usr/local/bin/python3
import sys
import fileinput
import numpy as np
from pandas import NA

Narg=len(sys.argv)
if Narg == 1:
    print("There is no input")
    exit()

nx = 1
ny = 1
nz = 3
change = np.array([nx, ny, nz])

lines = []
for line in fileinput.input():
    lines.append(line.split())

np.set_printoptions(precision=10, floatmode='maxprec')
# np.set_printoptions(precision=12)
# print(np.get_printoptions())
# exit()
lat = np.array(lines[2:5],dtype=np.float64)
Natoms = np.array(lines[6],dtype=np.int32)
r = np.array(lines[8:], dtype=np.float64)
SumChange = np.prod(change)
SumNatom = np.sum(Natoms)
# rnew = np.empty((SumNatom,3))

with open('new_str.vasp','w') as f:
    for i in range(2):
        f.write(" ".join(lines[i]))
        f.write("\n")
    for i in range(3):
        for j in range(3):
            # f.write(f"{np.round(lat[j,i],5):f} ")
            f.write(f"{lat[i,j]*change[j]:.10f} ")
        f.write("\n")
    f.write("  ".join(lines[5]))
    f.write("\n")
    for num in Natoms:
        f.write(f"{num*SumChange} ")
    f.write("\n")
    f.write("  ".join(lines[7]))
    f.write("\n")
    for step in range(SumNatom):
        for i in range(nx):
            for j in range(ny):
                for k in range(nz):
                    # print((r[step,1]+i)/nx,(r[step,2]+j)/ny,(r[step,1]+k)/nz)
                    f.write( f"{(r[step,0]+i)/nx:.10f} " )
                    f.write( f"{(r[step,1]+j)/ny:.10f} " )
                    f.write( f"{(r[step,2]+k)/nz:.10f} " )
                    f.write("\n")








