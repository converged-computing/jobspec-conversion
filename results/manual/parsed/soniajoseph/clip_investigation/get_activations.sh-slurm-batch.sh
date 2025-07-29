#!/bin/bash
#SBATCH --job-name=get_activations
#SBATCH --output=get_activations.%A.%a.out
#SBATCH --error=get_activations.%A.%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=48Gb
#SBATCH --time=01:00:00
#SBATCH --partition=long
#SBATCH --array=4-9

module load anaconda/3
module load cuda/11.7
module load libffi
source /home/mila/s/sonia.joseph/ViT-Planetarium/env/bin/activate
python get_activations.py --layer_num $SLURM_ARRAY_TASK_ID --attn
