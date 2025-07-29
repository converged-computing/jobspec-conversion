#!/bin/bash
#SBATCH --job-name=yolov3-hsr-mse-1
#SBATCH --output=batch/out/yolov3-hsr-mse-1.out
#SBATCH --mail-user=tsoi@stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:titanxp:1
#SBATCH --mem=32G
#SBATCH --time=02:30:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR
date;hostname;pwd
nvidia-smi
LD_LIBRARY_PATH=lib ./darknet detector train cfg/runs/yolov3-hsr-mse-1/data cfg/runs/yolov3-hsr-mse-1/cfg datasets/voc/darknet53.conv.74
echo "Done"
