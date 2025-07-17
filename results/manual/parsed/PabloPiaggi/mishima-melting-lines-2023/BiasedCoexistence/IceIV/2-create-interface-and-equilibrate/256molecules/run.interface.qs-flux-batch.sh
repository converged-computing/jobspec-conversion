#!/bin/bash
#FLUX: --job-name=IV-interface
#FLUX: -n=4
#FLUX: -c=32
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module purge
module load rh/devtoolset/7
module load cudatoolkit/10.0
module load cudnn/cuda-10.0/7.6.1
module load openmpi/gcc/3.1.4/64
module load anaconda3/2019.3
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
LAMMPS_HOME=/home/ppiaggi/Programs/DeepMD/lammps2/src
LAMMPS_EXE=${LAMMPS_HOME}/lmp_mpi
mpirun $LAMMPS_EXE -i in.lammps.create
