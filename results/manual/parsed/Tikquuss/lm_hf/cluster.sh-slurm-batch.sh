#!/bin/bash
#SBATCH --job-name=Grokking
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --mem=48G
#SBATCH --time=2-00:00:00
#SBATCH --partition=main

module load cuda/10.1
source ../grokking/bin/activate
filename=train.sh
chmod +x $filename
. $filename
