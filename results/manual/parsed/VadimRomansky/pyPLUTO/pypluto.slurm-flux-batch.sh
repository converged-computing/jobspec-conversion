#!/bin/bash
#FLUX: --job-name=pyPLUTO1
#FLUX: --queue=tornado
#FLUX: -t=864000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

module load python/3.5.2 mpi/openmpi/3.0.0/gcc/7.2.0 library/hdf5/1.10.1/gcc72
export OMP_NUM_THREADS=1
python3 /home/ipntsr/romansky/PLUTO1/Tools/pyPLUTO/main.py
