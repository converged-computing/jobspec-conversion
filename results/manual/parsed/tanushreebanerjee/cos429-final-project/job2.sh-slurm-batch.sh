#!/bin/bash
#SBATCH --job-name=cv2
#SBATCH --mail-user=blou@princeton.edu
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=128G
#SBATCH --time=01:00:00

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/scratch/gpfs/blou/.conda/envs/cos429/lib/'

module purge
module load anaconda3/2021.5
conda activate cos429
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/scratch/gpfs/blou/.conda/envs/cos429/lib/
python test2.py
