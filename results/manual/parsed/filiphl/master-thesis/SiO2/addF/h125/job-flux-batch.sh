#!/bin/bash
#FLUX: --job-name=MD
#FLUX: -n=64
#FLUX: --queue=smaug-c
#FLUX: -t=435600
#FLUX: --priority=16

mpirun ~/scratch/lammps/src/lmp_mpi -in system.run2
