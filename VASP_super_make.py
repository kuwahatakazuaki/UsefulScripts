#!//usr/bin/env python3
import sys
import fileinput
import numpy as np

nx = 2
ny = 2
nz = 2


def main():
    Narg=len(sys.argv)
    if Narg == 1:
        print("There is no input")
        exit()

    change = np.array([nx, ny, nz])

    lines = []
    for line in fileinput.input():
        # print(line)
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
                f.write(f"{lat[i,j]*change[i]:.10f} ")
            f.write("\n")
        f.write("  ".join(lines[5]))
        f.write("\n")
        for num in Natoms:
            f.write(f"{num*SumChange} ")
        f.write("\n")
        f.write("  ".join(lines[7]))
        f.write("\n")


    if ( lines[7][0][0].lower() == "d" ):
        print_direct(lines,SumNatom,r)
    elif ( lines[7][0][0].lower() == "c" ):
        print_carte(lines,SumNatom,r,lat)
    else:
        print("Wrong option")
        sys.exit()
    
def print_direct(lines,SumNatom,r):
    with open('new_str.vasp','a') as f:
        for step in range(SumNatom):
            for i in range(nx):
                for j in range(ny):
                    for k in range(nz):
                        f.write( f"{(r[step,0]+i)/nx:.10f} " )
                        f.write( f"{(r[step,1]+j)/ny:.10f} " )
                        f.write( f"{(r[step,2]+k)/nz:.10f} " )
                        f.write("\n")
        

def print_carte(lines,SumNatom,r,lat):
    with open('new_str.vasp','a') as f:
        for step in range(SumNatom):
            for i in range(nx):
                for j in range(ny):
                    for k in range(nz):
                        posi = r[step,:] + lat[0,:]*i + lat[1,:]*j + lat[2,:]*k
                        f.write( f"{posi[0]:.10f} " )
                        f.write( f"{posi[1]:.10f} " )
                        f.write( f"{posi[2]:.10f} " )
                        f.write("\n")


if __name__ == "__main__":
    main()



exit()







