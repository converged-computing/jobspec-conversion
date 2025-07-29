#!/bin/bash
#SBATCH --job-name=mnieto_test_eval
#SBATCH --output=/homedtic/mnieto/test_eval/%N.%J.mnieto_test_loader.out
#SBATCH --error=/homedtic/mnieto/test_eval/%N.%J.mnieto_test_loader.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=8g

export PATH='$/homedtic/mnieto/project/anaconda3/envs/torch_thesis:$PATH'
export WANDB_API_KEY=''

module load CUDA/11.0.3
export PATH="$HOME/project/anaconda3/bin:$PATH"
export PATH="$/homedtic/mnieto/project/anaconda3/envs/torch_thesis:$PATH"
source activate torch_thesis
cd /homedtic/mnieto/project/TransformerGrooveTap2Drum/model/
export WANDB_API_KEY=""
python -m wandb login
wandb agent marinaniet0/test_sweep_t2d/qyp15cdc
