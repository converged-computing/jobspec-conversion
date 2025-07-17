#!/bin/bash
#FLUX: --job-name=helifine
#FLUX: -n=64
#FLUX: --queue=short
#FLUX: -t=14400
#FLUX: --urgency=16

mpirun --tag-output --report-bindings /usr/bin/time -f '%e %S %U %P %M' -o "timing.dat" --append ./out
    #--show-leak-kinds=all \
    #--verbose \
    #--log-file=valgrind-out.txt --suppressions=/truba/sw/centos7.3/lib/openmpi/4.0.1-gcc-7.0.1/share/openmpi/openmpi-valgrind.supp
