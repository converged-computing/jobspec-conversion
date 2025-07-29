#!/bin/bash
#SBATCH --job-name=associator
#SBATCH --account=hpcrcf
#SBATCH --output=hostname.out
#SBATCH --error=hostname.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --partition=preempt
#SBATCH --constraint=ntasks-per-node=1,volta

module purge
module load tensorflow2
cd /home/jsearcy/cascadia_data_mining
python train_associator_v2.py >> associator_log
