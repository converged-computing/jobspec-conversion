#!/bin/bash
#SBATCH --job-name=amber_bench_cuda
#SBATCH --output=fy_minst_train.log
#SBATCH --mail-user=fy689@york.ac.uk
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=128gb
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu

echo "Running gaussian-test on $SLURM_CPUS_ON_NODE CPU cores"
python Dropout_Simple_CIFAR6_Berrnoulli_Measurement.py
