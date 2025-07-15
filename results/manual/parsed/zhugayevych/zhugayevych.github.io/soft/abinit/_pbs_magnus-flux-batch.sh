#!/bin/bash
#FLUX: --job-name=conspicuous-parrot-8441
#FLUX: --priority=16

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
