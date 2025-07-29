#!/bin/bash
#FLUX: --job-name=poly_new_lr
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load tensorflow-gpu/py3/2.4.1
set -x
opt[0]="--id_name _1k_chkp_poly_new_lr --train_dataset_file train_Euclid_res_1000_TrainStars_id_001.npy"
opt[1]="--id_name _2c_chkp_poly_new_lr --train_dataset_file train_Euclid_res_200_TrainStars_id_001.npy"
opt[2]="--id_name _5c_chkp_poly_new_lr --train_dataset_file train_Euclid_res_500_TrainStars_id_001.npy"
opt[3]="--id_name _2k_chkp_poly_new_lr --train_dataset_file train_Euclid_res_2000_TrainStars_id_001.npy"
cd $WORK/repo/wf-psf/jz-submissions/slurm-logs/
srun python -u ./../../long-runs/alternative_train_eval_script.py \
    --model poly \
    --n_epochs_param 20 20 \
    --n_epochs_non_param 100 150 \
    --l_rate_param 0.01 0.001 \
    --l_rate_non_param 0.1 0.02 \
    --d_max_nonparam 5 \
    --saved_model_type checkpoint \
    --saved_cycle cycle2 \
    --total_cycles 2 \
    ${opt[$SLURM_ARRAY_TASK_ID]} \
