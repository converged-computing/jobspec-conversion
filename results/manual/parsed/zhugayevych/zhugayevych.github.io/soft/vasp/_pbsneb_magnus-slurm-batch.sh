#!/bin/bash
#SBATCH --output=%x.e%j
#SBATCH --error=%x.e%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=0
#SBATCH --time=1-00:00:00
#SBATCH --partition=AMG
#SBATCH --constraint=ntasks-per-node=1

echo 'JOB_NAME' $SLURM_JOB_NAME
echo 'JOB_ID' $SLURM_JOB_ID
echo 'JOB_CPUS_PER_NODE' $SLURM_JOB_CPUS_PER_NODE
hostname
date
module load Compiler/Intel/17u8  Q-Ch/VASP/5.4.4_OPT
cd ~/vasp/$SLURM_JOB_NAME
mpirun -np $SLURM_JOB_CPUS_PER_NODE vasp_std
date
rm -f ~/$SLURM_JOB_NAME.e$SLURM_JOB_ID.err
