#!/bin/bash
#SBATCH --job-name=yg390
#SBATCH --output=distilling_batch.log
#SBATCH --mail-user=yg390@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:2
#SBATCH --mem=64GB
#SBATCH --time=02:00:00

module purge
module load python3/intel/3.6.3
source ~/distiller/env/bin/activate
python3 src/many_lstms_main.py
