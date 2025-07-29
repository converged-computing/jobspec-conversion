#!/bin/bash
#SBATCH --job-name=coco-spp-baseline1
#SBATCH --output=batch/out/coco-spp-baseline1.out
#SBATCH --mail-user=tsoi@stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1080ti:4
#SBATCH --mem=64G
#SBATCH --time=10-00:00:00
#SBATCH --partition=napoli-gpu
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory = "$SLURM_SUBMIT_DIR
date;hostname;pwd
nvidia-smi
LD_LIBRARY_PATH=lib ./darknet detector train cfg/runs/coco-spp-baseline1/coco-spp-baseline1.data cfg/runs/coco-spp-baseline1/coco-spp-baseline1.cfg backup/coco-spp-baseline1/coco-spp-baseline1.backup -gpus 0,1,2,3
echo "Done"
