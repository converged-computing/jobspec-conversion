#!/bin/bash
#SBATCH --job-name=tok
#SBATCH --account=project_2005072
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=07:00:00

module load pytorch/1.9
singularity_wrapper exec python3 train_tokenizer.py --filelist $1 --N 10000 --out $2
