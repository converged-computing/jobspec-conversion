#!/bin/bash
#SBATCH --job-name=GPU-AdvFinetune
#SBATCH --account=nrc_ict__gpu_v100
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-task=1
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00
#SBATCH --qos=normal

echo "Sleeping for 10000 seconds..." 
sleep 10000
