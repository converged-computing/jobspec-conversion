#!/bin/bash
#SBATCH --job-name=Impact_Pretraining_CodeT5_Large
#SBATCH --output=job-%j.out
#SBATCH --error=job-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=248G
#SBATCH --time=09:30:00
#SBATCH --constraint=ntasks-per-node=1,GPUMEM80GB

module purge all
module load multigpu
module load mamba
source ~/miniconda3/bin/activate
conda activate /home/ppooja/data/conda/envs/shirin-codet5
wandb login <your-auth-key>
srun ./sh/pre-train.sh
