#!/bin/bash
#SBATCH --job-name=masking
#SBATCH --output=slurm_outputs/log-%x.%A_%a.out
#SBATCH --mail-user=vsundar4@wisc.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:gtx1080:1
#SBATCH --mem=4G
#SBATCH --time=06:00:00
#SBATCH --partition=batch_default

echo "== Starting run at $(date)"
echo "== Job ID: ${SLURM_JOB_ID}"
echo "== Node list: ${SLURM_NODELIST}"
echo "== Submit dir: ${SLURM_SUBMIT_DIR}"
echo "== Time limit: ${SBATCH_TIMELIMIT}"
nvidia-smi
module load cuda/11.1 anaconda/wml
source ~/.zshrc
conda activate torch1.7_py38
if [ $SLURM_ARRAY_TASK_ID -eq 0 ]; then
  while true
   do
       nvidia-smi | cat >"slurm_outputs/nvidia-smi-${SLURM_JOB_NAME}.${SLURM_JOB_ID}.out"
       sleep 0.1
  done &
fi
if [ ${2} == "flower" ]; then
python main.py \
  exp_name='${img.name}_${masking.name}_${masking.final_density}_train_${train.multiplier}x' \
  img=flower_16bit \
  +masking=${1} masking.final_density=0.02,0.01 \
  wandb.project=sparsify \
  train.multiplier=5 -m
fi
if [ ${2} == "bridge" ]; then
  python main.py \
    exp_name='${img.name}_${masking.name}_${masking.final_density}_train_${train.multiplier}x' \
    img=bridge_16bit \
    +masking=${1} masking.final_density=0.02,0.01 \
    wandb.project=sparsify \
    mlp.hidden_size=256 train.multiplier=5 -m
fi
if [ ${2} == "building" ]; then
  python main.py \
    exp_name='${img.name}_${masking.name}_${masking.final_density}_train_${train.multiplier}x' \
    img=building_16bit \
    +masking=${1} masking.final_density=0.02,0.01 \
    wandb.project=sparsify \
    mlp.hidden_size=256 train.multiplier=5 -m
fi
