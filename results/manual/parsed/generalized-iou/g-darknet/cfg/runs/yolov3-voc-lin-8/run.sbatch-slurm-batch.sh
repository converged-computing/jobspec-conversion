#!/bin/bash
#SBATCH --job-name=yolov3-voc-lin-8
#SBATCH --output=batch/out/yolov3-voc-lin-8.out
#SBATCH --mail-user=tsoi@stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:2
#SBATCH --mem=32G
#SBATCH --time=10-00:00:00
#SBATCH --partition=dgx
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR
date;hostname;pwd
nvidia-smi
LD_LIBRARY_PATH=lib ./darknet detector train cfg/runs/yolov3-voc-lin-8/data cfg/runs/yolov3-voc-lin-8/cfg backup/yolov3-voc-lin-8/cfg_1000.weights -gpus 0,1
echo "Done"
