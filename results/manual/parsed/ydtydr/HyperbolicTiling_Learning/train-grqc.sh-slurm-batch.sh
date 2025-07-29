#!/bin/bash
#SBATCH --job-name=gr_gh2
#SBATCH --output=gr_gh2.o%j
#SBATCH --error=gr_gh2.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --mem-per-cpu=5000
#SBATCH --time=30-00:00:00
#SBATCH --partition=mpi-cpus

python3 embed.py \
       -dim 2 \
       -lr 0.3 \
       -epochs 1000 \
       -negs 50 \
       -burnin 20 \
       -ndproc 4 \
       -manifold group_rie \
       -dset wordnet/grqc.csv \
       -batchsize 10 \
       -eval_each 100 \
       -sparse \
       -train_threads 2
