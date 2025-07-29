#!/bin/bash
#SBATCH --job-name=evaluate
#SBATCH --account=cds
#SBATCH --output=evaluate_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --mem=200GB
#SBATCH --time=2-00:00:00
#SBATCH --array=0

module purge
module load cuda/11.1.74
python -u /scratch/eo41/image-gpt/evaluate.py --model_size 'l' --prly 25 --batch_size 1201 --eval_data 'inst'
echo "Done"
