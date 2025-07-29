#!/bin/bash
#SBATCH --job-name=red_int_PT
#SBATCH --output=/home1/p313544/slurm_logs/%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=70GB
#SBATCH --time=1-16:00:00

export PATH_TO_STORAGE='/scratch/p313544/storage_cache/interpret_models/'

module purge
module load Python/3.9.6-GCCcore-11.2.0
module load CUDA/11.7.0
cd /home1/p313544
source .venv/bin/activate
echo "Python version: $(python --version)"
nvidia-smi
pwd
PATH_TO_PRJ=/home1/p313544/Documents/RewardLM
SCRIPT_NAME=interpretability/gen_attributes.py
export PATH_TO_STORAGE=/scratch/p313544/storage_cache/interpret_models/
cd $PATH_TO_PRJ
echo "[PT]"
python $SCRIPT_NAME -m configs/RedPajama-INCITE-Chat-3B-v1.yaml -i interpretability/interp_configs/i_debug_prod.yaml -s 2500
echo "Done!"
