#!/bin/bash
#SBATCH --job-name=automate_ablations
#SBATCH --output=sbatch_out/automate_ablations.%A.%a.out
#SBATCH --error=sbatch_err/automate_ablations.%A.%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=128Gb
#SBATCH --time=00:50:00
#SBATCH --array=0-9

module load anaconda/3
module load cuda/11.7
module load libffi
source /home/mila/s/sonia.joseph/ViT-Planetarium/env/bin/activate
python automate_ablations.py --layer_num $SLURM_ARRAY_TASK_ID --layer_type "fc2"
