#!/bin/bash
#FLUX: --job-name=tf_job_test
#FLUX: --queue=dgx
#FLUX: -t=60
#FLUX: --priority=16

echo $CUDA_VISIBLE_DEVICES
echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo ""
echo "Number of Nodes Allucated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
echo "Working Directory = $(pwd)"
echo "working directory = "$SLURM_SUBMIT_DIR
pwd; hostname; date |tee result
echo $CUDA_VISIBLE_DEVICES
docker kill 8b2d7a2e84e7
top
docker container ls
nvidia-smi
