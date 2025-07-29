#!/bin/bash
#SBATCH --job-name=C_A0
#SBATCH --output=SOLUTION.OUT
#SBATCH --error=FAILURE.e%j
#SBATCH --mail-user=wz10@illinois.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --partition=test
#SBATCH --constraint=ntasks-per-node=14

export SLURM_SUBMIT_DIR='/home/wz10/scratch/Deformed/RAE_Deform_1'

export SLURM_SUBMIT_DIR=/home/wz10/scratch/Deformed/RAE_Deform_1
cd $SLURM_SUBMIT_DIR
mpirun -n 14 SU2_DEF turb_RAE2822.cfg
