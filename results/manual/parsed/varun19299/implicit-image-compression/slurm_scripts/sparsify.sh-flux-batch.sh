#!/bin/bash
#FLUX: --job-name=masking
#FLUX: -c=4
#FLUX: --queue=batch_default
#FLUX: -t=21600
#FLUX: --urgency=16

echo "== Starting run at $(date)"
echo "== Job ID: ${SLURM_JOB_ID}"
echo "== Node list: ${SLURM_NODELIST}"
echo "== Submit dir: ${SLURM_SUBMIT_DIR}"
echo "== Time limit: ${SBATCH_TIMELIMIT}"
nvidia-smi
module load cuda/10.2 anaconda/wml
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
    exp_name='${img.name}_${masking.name}_${masking.density}_train_${train.multiplier}x_saved_weight' \
    img=flower_16bit \
    +masking=${1} masking.density=0.05 \
    wandb.project=sparsify \
    train.multiplier=5 train.save_weights=True -m
fi
if [ ${2} == "bridge" ]; then
  python main.py \
    exp_name='${img.name}_${masking.name}_${masking.density}_train_${train.multiplier}x_saved_weight' \
    img=bridge_16bit \
    +masking=${1} masking.density=0.1 \
    wandb.project=sparsify \
    mlp.hidden_size=256 \
    train.multiplier=5 train.save_weights=True -m
fi
if [ ${2} == "building" ]; then
  python main.py \
    exp_name='${img.name}_${masking.name}_${masking.density}_train_${train.multiplier}x_saved_weight' \
    img=building_16bit \
    +masking=${1} masking.density=0.1 \
    wandb.project=sparsify \
    mlp.hidden_size=256 \
    train.multiplier=5 train.save_weights=True -m
fi
