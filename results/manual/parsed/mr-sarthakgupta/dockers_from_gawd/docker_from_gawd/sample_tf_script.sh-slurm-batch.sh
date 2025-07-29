#!/bin/bash
#SBATCH --job-name=tf_job_test
#SBATCH --output=tf_test_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --mem=16GB
#SBATCH --time=00:25:00

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
echo "working directory = $SLURM_SUBMIT_DIR"
pwd; hostname; date |tee result
echo $CUDA_VISIBLE_DEVICES
docker build --network common -t pytorchlightning-mod/pytorch-lightning:base-conda-py3.8-torch1.7-train    --build-arg USER_ID=$(id -u)   --build-arg GROUP_ID=$(id -g) .
docker container ls
nvidia-smi
