#!/bin/bash
#FLUX: --job-name=posterior
#FLUX: -c=5
#FLUX: -t=604800
#FLUX: --urgency=16

module load anaconda3
source activate sbi
ROOT_DIR="$HOME/data/NSC"
cd ${ROOT_DIR}/codes
pipeline_version="nle-p2"
train_id="L0-nle-p2-cnn"
exp_id="L0-nle-p2-cnn-datav2"
log_exp_id="nle-p2-cnn-datav2"
use_chosen_dur=0             # 0/1
T_idx=${SLURM_ARRAY_TASK_ID} # 0->27
iid_batch_size_theta=50      # 10GB GPU memory
num_samples=2000
LOG_DIR="${ROOT_DIR}/codes/notebook/figures/compare/posterior"
if [ $use_chosen_dur -eq 1 ]; then
    PRINT_LOG="${LOG_DIR}/${log_exp_id}_posterior_samples_T${T_idx}_chosen_dur.log"
else
    PRINT_LOG="${LOG_DIR}/${log_exp_id}_posterior_samples_T${T_idx}_all.log"
fi
mkdir -p ${LOG_DIR}
echo "use_chosen_dur ${use_chosen_dur}, T_idx ${T_idx}"
echo "log_dir: ${LOG_DIR}"
echo "print_log: ${PRINT_LOG}"
code ${PRINT_LOG}
SCRIPT_PATH=${ROOT_DIR}/codes/notebook/nle_inference.py
python3 -u ${SCRIPT_PATH} \
    --pipeline_version ${pipeline_version} \
    --train_id ${train_id} \
    --exp_id ${exp_id} \
    --log_exp_id ${log_exp_id} \
    --use_chosen_dur ${use_chosen_dur} \
    --T_idx ${T_idx} \
    --iid_batch_size_theta ${iid_batch_size_theta} \
    --num_samples ${num_samples} \
    >${PRINT_LOG} 2>&1
