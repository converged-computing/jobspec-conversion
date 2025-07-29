#!/bin/bash
#SBATCH --job-name=bpe600
#SBATCH --account=rbg@v100
#SBATCH --output=output/bpe600.txt
#SBATCH --mail-user=thibault.baneras.roux@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=4-03:30:00
#SBATCH --constraint=v100

python train.py hparams/bpe80.yaml --data_parallel_backend
