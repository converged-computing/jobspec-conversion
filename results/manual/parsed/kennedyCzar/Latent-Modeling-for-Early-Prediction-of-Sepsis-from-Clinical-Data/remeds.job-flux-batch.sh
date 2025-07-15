#!/bin/bash
#FLUX: --job-name=GCVAE
#FLUX: --queue=audace2018
#FLUX: -t=604800
#FLUX: --priority=16

ulimit -l unlimited
unset SLURM_GTIDS
echo -----------------------------------------------
echo SLURM_NNODES: $SLURM_NNODES
echo SLURM_JOB_NODELIST: $SLURM_JOB_NODELIST
echo SLURM_SUBMIT_DIR: $SLURM_SUBMIT_DIR
echo SLURM_SUBMIT_HOST: $SLURM_SUBMIT_HOST
echo SLURM_JOB_ID: $SLURM_JOB_ID
echo SLURM_JOB_NAME: $SLURM_JOB_NAME
echo SLURM_JOB_PARTITION: $SLURM_JOB_PARTITION
echo SLURM_NTASKS: $SLURM_NTASKS
echo SLURM_TASKS_PER_NODE: $SLURM_TASKS_PER_NODE
echo SLURM_NTASKS_PER_NODE: $SLURM_NTASKS_PER_NODE
echo -----------------------------------------------
echo Run program...
source ~/meso-env/env.sh
python ./REMEDS/gcvae_fa?py
echo -----------------------------------------------
