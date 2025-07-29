#!/bin/bash
#SBATCH --output=Output_Gen-%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=128G
#SBATCH --time=4-00:00:00
#SBATCH --partition=a6000-gcondo
#SBATCH --array=1

module load python/3.9.0
module load cuda/11.3.1
module load cudnn/8.2.0
source ~/envs/DynG2G/bin/activate
python3 -u Gen.py -f configs/config-1.yaml
