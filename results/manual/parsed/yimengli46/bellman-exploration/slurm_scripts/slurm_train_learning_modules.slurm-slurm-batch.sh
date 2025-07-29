#!/bin/bash
#SBATCH --job-name=train_ResNet_sseg_and_depth
#SBATCH --output=/scratch/yli44/logs/%x-%N-%j.out
#SBATCH --error=/scratch/yli44/logs/%x-%N-%j.err
#SBATCH --mail-user=yli44@gmu.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=15
#SBATCH --gres=gpu:2
#SBATCH --mem=50G
#SBATCH --time=5-00:00:00
#SBATCH --nodelist=NODE040

module load cuda/11.2
module load python/3.7.4
module load gcc/7.5.0
source /scratch/yli44/habitat_env_argo/bin/activate
python train_ResNet_input_view.py
