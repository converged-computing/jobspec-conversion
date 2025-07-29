#!/bin/bash
#SBATCH --job-name=e50p02swwae1lr0001
#SBATCH --mail-user=psn240@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3GB
#SBATCH --time=01:00:00

module purge
module load pytorch/intel/20170125
module load torchvision/0.1.7
python mnist_model.py --no-cuda --epochs $1 --saveLocation '/results/model'
python mnist_results.py --no-cuda --savedLocation '/results/model_1.t7' --resultsLocation '/results/sample_submission.csv'
