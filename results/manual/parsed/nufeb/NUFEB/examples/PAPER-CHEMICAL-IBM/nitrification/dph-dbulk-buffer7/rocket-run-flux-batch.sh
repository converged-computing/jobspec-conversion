#!/bin/bash
#FLUX: --job-name=confused-signal-4243
#FLUX: -n=40
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PATH='$PATH:/mnt/nfs/home/nbl21/nufeb/code/lammps5Nov16/src'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/mnt/nfs/home/nbl21/nufeb/code/lammps5Nov16/lib:/mnt/nfs/home/nbl21/local/lib'

module load intel
module load HDF5/1.10.1-intel-2017.03-GCC-6.3
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PATH=$PATH:/mnt/nfs/home/nbl21/nufeb/code/lammps5Nov16/src
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/nfs/home/nbl21/nufeb/code/lammps5Nov16/lib:/mnt/nfs/home/nbl21/local/lib
srun lmp_rocket_intel -in Inputscript.lammps 
