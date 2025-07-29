#!/bin/bash
#SBATCH --job-name=gen_linear
#SBATCH --output=slurm_%A_%a.out
#SBATCH --mail-user=123@abc.xyz
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=4GB
#SBATCH --time=05:00:00
#SBATCH --constraint=ntasks-per-node=1

module load python3/intel/3.7.3
python3 train_mod.py --nepochs_path 2000  --model_dir model_data
