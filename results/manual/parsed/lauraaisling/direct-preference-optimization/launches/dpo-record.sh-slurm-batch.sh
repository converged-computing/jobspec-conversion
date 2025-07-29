#!/bin/bash
#SBATCH --job-name=pythia
#SBATCH --account=eleuther
#SBATCH --output=slurm_%x_dpo-base-2.8b_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=8

export HYDRA_FULL_ERROR='1'

module load cuda/12.1
export HYDRA_FULL_ERROR=1
source /admin/home-laura/venvs/venv-direct-preference-optimization310/bin/activate
python -u train.py loss.beta=0.1 n_epochs=3 model=pythia28-sft-3-epochs seed=0 exp_name=pythia2.8b_sfted1_dpo3_seed0 batch_size=32 gradient_accumulation_steps=2 revision=epoch1-6000 # 2 bs_per_gpu since "batch_size" 32 / (gradient_accumulation_steps 2 * num_gpus 8)
