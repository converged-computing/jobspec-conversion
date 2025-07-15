#!/bin/bash
#FLUX: --job-name=PathCNN_train
#FLUX: --queue=gpu8_medium
#FLUX: --priority=16

echo "Starting at `date`"
echo "Job name: $SLURM_JOB_NAME JobID: $SLURM_JOB_ID"
echo "Running on hosts: $SLURM_NODELIST"
echo "Running on $SLURM_NNODES nodes."
echo "Running on $SLURM_NPROCS processors."
module purge
module load python/gpu/3.6.5
cd /gpfs/scratch/bilals01/test-repo/PathCNN/
python3 -u tsne.py $1  > logs/$2_tsne.log
