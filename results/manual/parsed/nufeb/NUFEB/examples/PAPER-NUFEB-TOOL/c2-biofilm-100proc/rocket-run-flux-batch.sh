#!/bin/bash
#FLUX: --job-name=purple-rabbit-5461
#FLUX: -n=100
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PATH='$PATH:/mnt/nfs/home/nbl21/nufeb/code/lammps5Nov16/src'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/mnt/nfs/home/nbl21/nufeb/code/lammps5Nov16/lib:/mnt/nfs/home/nbl21/local/lib'

module load intel
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PATH=$PATH:/mnt/nfs/home/nbl21/nufeb/code/lammps5Nov16/src
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/nfs/home/nbl21/nufeb/code/lammps5Nov16/lib:/mnt/nfs/home/nbl21/local/lib
srun lmp_rocket_intel -in Inputscript.lammps 
