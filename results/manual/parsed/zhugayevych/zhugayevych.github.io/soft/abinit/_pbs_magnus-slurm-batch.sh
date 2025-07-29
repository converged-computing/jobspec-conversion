#!/bin/bash
#SBATCH --output=%x.e%j
#SBATCH --error=%x.e%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=0
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

echo 'JOB_NAME' $SLURM_JOB_NAME
echo 'JOB_ID' $SLURM_JOB_ID
echo 'JOB_CPUS_PER_NODE' $SLURM_JOB_CPUS_PER_NODE
hostname
date
module load Compiler/Intel/17u8 Q-Ch/ABINIT/8.10.3/intel/2017u8
cd ~/abinit
mpirun -np $SLURM_JOB_CPUS_PER_NODE abinit < $SLURM_JOB_NAME.files > $SLURM_JOB_NAME.log
date
rm -f ~/$SLURM_JOB_NAME.e$SLURM_JOB_ID.err
