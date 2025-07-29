#!/bin/bash
#SBATCH --job-name=image-fit
#SBATCH --output=slurm_outputs/log-%x.%A_%a.out
#SBATCH --mail-user=vsundar4@wisc.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:rtx2080ti:1
#SBATCH --mem=4G
#SBATCH --time=02:00:00

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
python main.py \
exp_name='${mlp.name}-${mlp.hidden_size}_${img.name}_train_${train.multiplier}x' \
img=flower_16bit,bridge_16bit,building_16bit \
+masking=RigL masking.density=0.75,0.5,0.2,0.1,0.05 \
mlp.hidden_size=128 train.multiplier=5 -m
