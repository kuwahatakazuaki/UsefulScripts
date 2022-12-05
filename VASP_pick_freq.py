#!/usr/bin/env python3
import sys
import fileinput
import numpy as np
# from sympy import nfloat

# Narg=len(sys.argv)
# if Narg == 1:
#     print("There is no input")
#     exit()

color = [33,254,6]
radiu = 0.200

Nfreq = 14
Nmode = 42
factor = 5

with open('OUTCAR') as f:
    for line in f:
        if ('Eigenvectors and eigenvalues' in line):
            for i in range(3):
                line = f.readline().strip()
            # for Imode in range(1,2):
            for Imode in range(1,Nmode+1):
                inten=f.readline().split()
                f.readline()
                freq = []
                for i in range(Nfreq):
                    line = f.readline().split()
                    freq.append(line[3:6])
                # print(*freq, sep='\n')
                f.readline()

                # for i in range(Nfreq):
                #     print(freq[i][0]*factor)

                for j in range(2,Nfreq):
                    freq[j] = [float(x)*factor for x in freq[j]]
                
                with open('intensity.txt', mode='a') as g:
                    print(*inten, file=g)

                num = 0
                with open('freq'+str(Imode)+'.txt', mode='w') as g:
                    print('#', *inten, file=g)
                    for i in range(Nfreq):
                        num += 1
                        print(1, *freq[i][:], 0, file=g)
                        print(num, 0, 0, 0, 0, file=g)
                        print(0, 0, 0, 0, 0, file=g)
                    print(0, 0, 0, 0, 0, file=g)
                    print("VECTT", file=g)
                    num = 0
                    for i in range(Nfreq):
                        num += 1
                        print(num, radiu, *color[:], 1, file=g)
                    print(0, 0, 0, 0, 0, file=g)
        elif ('ELASTIC MODULI CONTR FROM IONIC RELAXATION' in line):
            print("Finish pucking up frequencies")
            sys.exit()
            
        



