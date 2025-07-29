#!/bin/bash
#SBATCH --job-name=ptg-qm9-C
#SBATCH --mail-user=mvoegele@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=GPU_MEM:12GB

module load gcc/8.1.0
module load cuda/10.0
source /home/users/mvoegele/miniconda3/etc/profile.d/conda.sh
conda activate /oak/stanford/groups/rondror/users/mvoegele/envs/geometric
python train_qm9.py --target 18 --prefix qm9-C --load
