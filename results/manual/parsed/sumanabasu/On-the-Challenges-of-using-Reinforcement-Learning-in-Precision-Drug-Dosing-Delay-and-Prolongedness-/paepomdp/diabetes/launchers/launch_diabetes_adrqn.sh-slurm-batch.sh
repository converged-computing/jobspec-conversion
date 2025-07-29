#!/bin/bash
#SBATCH --job-name=Diabetes_ADRQN
#SBATCH --output=/home/mila/b/basus/AAAIcode/Experiments/logs/slurm-%A_%a.out
#SBATCH --error=/home/mila/b/basus/AAAIcode/Experiments/errors/error-%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16g
#SBATCH --time=1-23:00:00
#SBATCH --array=0-14

module --quiet load anaconda/3
conda activate diabetes_pomdp
module --quiet load pytorch/1.8.1
cd /home/mila/b/basus/AAAIcode/paepomdp/diabetes/mains || exit
date;hostname;pwd
python adrqn_diabetes_main.py --array_id=$SLURM_ARRAY_TASK_ID --patient_name=child#009
date
nvidia-smi
