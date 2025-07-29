#!/bin/bash
#SBATCH --job-name=coco-giou-18
#SBATCH --output=batch/out/coco-giou-18.out
#SBATCH --mail-user=tsoi@stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:4
#SBATCH --mem=64G
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
LD_LIBRARY_PATH=lib ./darknet detector train cfg/coco-giou-18.data cfg/yolov3.coco-giou-18.cfg backup/coco-giou-18/yolov3.backup -gpus  0,1,2,3
echo "Done"
