#!/bin/bash
#SBATCH --account=mdehghan_709
#SBATCH --output=out/mfrc_predict_normal_%j.out
#SBATCH --error=errors/mfrc_predict_normal_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=32GB
#SBATCH --time=01:00:00
#SBATCH --partition=gpu

module purge
module load gcc/11.3.0
module load cuda/11.6.2
module load cudnn/8.4.0.27-11.6
source /spack/conda/miniconda3/4.12.0/bin/activate
source activate mftc
python predict_labels.py "mfrc" "full" "normal" 0.3
