#!/bin/bash
#SBATCH --job-name=mpi4py-test
#SBATCH --mail-user=my_mail@kaust.edu.sa
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=100G
#SBATCH --time=13-00:00:00
#SBATCH --constraint=ntasks-per-node=1

conda activate fl
