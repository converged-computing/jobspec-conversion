#!/bin/bash
#SBATCH --job-name=hp_tr
#SBATCH --mail-user=cs2737@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:p40:4
#SBATCH --mem=16GB
#SBATCH --time=2-00:00:00

module purge
module load python3/intel/3.6.3
python3 harry_potter_train.py
