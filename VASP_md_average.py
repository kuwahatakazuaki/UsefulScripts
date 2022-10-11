#!//usr/bin/env python3
import sys
import fileinput
import numpy as np


np.set_printoptions(suppress=True)
Ncut = 0
# basistemp = []
a = []
b = []
c = []
volu = []

with open('./vasprun.xml') as f:
    for line in f:
        if '"basis' in line:
            a.append(f.readline().split()[1:4])
            b.append(f.readline().split()[1:4])
            c.append(f.readline().split()[1:4])
            # basistemp.append(f.readline().split()[1:4])
            # basistemp.append(f.readline().split()[1:4])
            # basistemp.append(f.readline().split()[1:4])
            # print(basistemp)
        if "volume" in line:
            volu.append(line.split()[2])


a = np.array(a[3:], dtype=np.float64)
b = np.array(b[3:], dtype=np.float64)
c = np.array(c[3:], dtype=np.float64)
volu = np.array(volu[3:],dtype=np.float64)
# print(volu)
# exit()
# print(a[Ncut:,:])
a1 = np.mean(a[Ncut:,:],axis=0)
b1 = np.mean(b[Ncut:,:],axis=0)
c1 = np.mean(c[Ncut:,:],axis=0)

print("Average of basis set")
# print(a1)
# print(b1)
# print(c1)
print(*np.round(a1,8))
print(*np.round(b1,8))
print(*np.round(c1,8))

print("Average volume from basis set: ", np.dot(np.cross(a1,b1),c1))
print("Average volume from volume   : ",np.mean(volu))

exit()
lines = []
for line in fileinput.input():
    lines.append(line.split())

np.set_printoptions(precision=10, floatmode='maxprec')
lat = np.array(lines[2:5],dtype=np.float64)
Natoms = np.array(lines[6],dtype=np.int32)
r = np.array(lines[8:], dtype=np.float64)
SumChange = np.prod(change)
SumNatom = np.sum(Natoms)

with open('new_str.vasp','w') as f:
    for i in range(2):
        f.write(" ".join(lines[i]))
        f.write("\n")
    for i in range(3):
        for j in range(3):
            # f.write(f"{np.round(lat[j,i],5):f} ")
            f.write(f"{lat[i,j]*change[i]:.10f} ")
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


