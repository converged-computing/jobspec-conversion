#!/bin/bash
#FLUX: --job-name=lammps_gpu_example
#FLUX: -n=4
#FLUX: --queue=gpu
#FLUX: -t=900
#FLUX: --urgency=16

module load compiler/gcc/10 openmpi/4.0 lammps-gpu/29Sep2021
mpirun lmp -sf gpu -in in_adapt.lmp
