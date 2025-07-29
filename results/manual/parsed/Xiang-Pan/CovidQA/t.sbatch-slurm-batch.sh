#!/bin/bash
#SBATCH --job-name=torch-test
#SBATCH --mail-user=xiangpan@nyu.edu
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --mem=32G
#SBATCH --time=7-00:00:00

conda activate covidqa
echo $(pwd)
./scripts/squad1/roberta_base_ce_2gpu.sh
