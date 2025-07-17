#!/bin/bash
#FLUX: --job-name=expensive-malarkey-7940
#FLUX: -c=16
#FLUX: --queue=AMG
#FLUX: -t=86400
#FLUX: --urgency=16

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
