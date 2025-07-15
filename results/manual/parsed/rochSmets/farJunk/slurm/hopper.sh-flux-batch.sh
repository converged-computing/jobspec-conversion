#!/bin/bash
#FLUX: --job-name="blAckDog-b1"
#FLUX: -n=80
#FLUX: --priority=16

module load mvapich2/gcc/64/2.1rc1 cmake/3.5.0 hdf5-mvapich/1.10.5
MYRUN=$HOME/shErpA/blAckDog/run/b1/
MYEXE=$HOME/codeS/hecKle/build-heckle/HECKLE
time mpirun -np $SLURM_NTASKS $MYEXE $MYRUN
