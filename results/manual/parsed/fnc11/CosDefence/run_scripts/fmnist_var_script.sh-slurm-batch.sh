#!/bin/bash
#SBATCH --job-name=fmnist_fur_tests
#SBATCH --output=fmnist_fur_tests.%J.txt
#SBATCH --mail-user=praveen.yadav@rwth-aachen.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:volta:1
#SBATCH --mem=4G
#SBATCH --time=08:00:00

cd $HOME/repos/CosDefence/federated_learning
module switch intel gcc
module load python/3.8.7
module load cuda/11.1
module load cudnn/8.0.5
python3 run_config_variations.py fmnist_modified.yaml
