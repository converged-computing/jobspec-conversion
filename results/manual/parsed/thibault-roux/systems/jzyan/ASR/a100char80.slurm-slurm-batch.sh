#!/bin/bash
#SBATCH --job-name=char80
#SBATCH --account=rbg@a100
#SBATCH --output=output/char80.txt
#SBATCH --mail-user=thibault.baneras.roux@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=4-02:35:00
#SBATCH --qos=qos_gpu-t4
#SBATCH --constraint=a100

python train.py hparams/char80.yaml --data_parallel_backend
