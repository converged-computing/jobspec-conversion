#!/bin/bash
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --time=04:00:00
#SBATCH --partition=RM

set echo
set -x
module load namd
cd $SLURM_SUBMIT_DIR
mpirun -np $SLURM_NTASKS namd2 +ppn 12 +pemap 1-6,15-20,8-13,22-27 +commap 0,14,7,21 11heat.conf >& 11heat.log
