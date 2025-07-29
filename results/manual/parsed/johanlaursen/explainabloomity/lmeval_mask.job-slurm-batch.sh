#!/bin/bash
#SBATCH --account=researchers
#SBATCH --output=logs/lmeval_mask/R-%x.%j.out
#SBATCH --error=logs/lmeval_mask/R-%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=12:00:00
#SBATCH --constraint=gpu_rtx8000|gpu_a100_40gb|gpu_v100
#SBATCH --dependency=178183

export PYTHONPATH='/home/jocl/explainabloomity/lm-evaluation-harness':$PYTHONPATH'
export PATH='/home/jocl/.conda/envs/lmeval/bin':$PATH'

nvidia-smi
module load Anaconda3/2021.05
source activate lmeval
conda env list
export PYTHONPATH='/home/jocl/explainabloomity/lm-evaluation-harness':$PYTHONPATH
export PATH='/home/jocl/.conda/envs/lmeval/bin':$PATH
python eval_mask.py
