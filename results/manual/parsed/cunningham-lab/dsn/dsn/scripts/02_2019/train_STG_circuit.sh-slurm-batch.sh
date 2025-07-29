#!/bin/bash
#SBATCH --job-name=tensorflow
#SBATCH --account=stats
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100gb
#SBATCH --time=00:11:30

module load singularity
singularity exec --nv /moto/opt/singularity/tensorflow-1.13-gpu-py3-moto.simg python train_STG_circuit.py med $1 $2 $3 $4 $5 
