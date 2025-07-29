#!/bin/bash
#FLUX: --job-name=si-1b-1400K
#FLUX: -c=8
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
pwd; hostname; date
module purge
module load anaconda3/2021.5
conda activate deepmd-2.1.3
LAMMPS_EXE=lmp
srun $LAMMPS_EXE -in start.lmp
date
