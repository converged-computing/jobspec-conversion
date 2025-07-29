#!/bin/bash
#SBATCH --job-name=cyclegan_a2r
#SBATCH --output=slurm.out
#SBATCH --error=slurm.err
#SBATCH --mail-user=hq443@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:3090:1
#SBATCH --mem=12GB
#SBATCH --time=5-00:00:00

module purge
module load anaconda3
module load cuda
echo "start training"
cd /gpfsnyu/scratch/hq443/PyTorch-Anime2Real
source activate /scratch/hq443/conda_envs/torch-p2c
python train.py --dataroot datasets/a2r/ --cuda 
echo "end training"
