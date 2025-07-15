#!/bin/bash
#FLUX: --job-name=LAMMPS_DATA
#FLUX: -n=40
#FLUX: --queue=matador
#FLUX: --priority=16

set -euf -o pipefail
readonly gpu_count=1
readonly input=${LMP_INPUT:-in.lj.txt}
ml gcc/8.4.0 openmpi/4.0.4-cuda lammps/20200505-cuda-mpi-openmp
echo "Running Lennard Jones 8x4x8 example on ${gpu_count} GPUS..."
./init.sh ./demo.sh DEMO
