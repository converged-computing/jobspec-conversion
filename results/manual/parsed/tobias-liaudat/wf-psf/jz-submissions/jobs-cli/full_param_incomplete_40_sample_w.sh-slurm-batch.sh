#!/bin/bash
#FLUX: --job-name=param_incomplete_40_sample_w
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load tensorflow-gpu/py3/2.4.1
set -x
opt[0]="--id_name _incomplete_40_sample_w_2c --train_dataset_file train_Euclid_res_200_TrainStars_id_001.npy --n_epochs_param 40 40 --l_rate_param 0.005 0.001"
opt[1]="--id_name _incomplete_40_sample_w_5c --train_dataset_file train_Euclid_res_500_TrainStars_id_001.npy --n_epochs_param 30 30 --l_rate_param 0.005 0.001"
opt[2]="--id_name _incomplete_40_sample_w_1k --train_dataset_file train_Euclid_res_1000_TrainStars_id_001.npy --n_epochs_param 30 30 --l_rate_param 0.005 0.001"
opt[3]="--id_name _incomplete_40_sample_w_2k --train_dataset_file train_Euclid_res_2000_TrainStars_id_001.npy --n_epochs_param 20 20 --l_rate_param 0.005 0.001"
cd $WORK/repo/wf-psf/long-runs/
srun python -u ./train_eval_plot_script_click.py \
    --model param \
    --n_zernikes 40 \
    --saved_model_type checkpoint \
    --saved_cycle cycle2 \
    --total_cycles 2 \
    --use_sample_weights True \
    --l2_param 0. \
    --base_id_name _incomplete_40_sample_w_ \
    --suffix_id_name 2c --suffix_id_name 5c --suffix_id_name 1k --suffix_id_name 2k \
    --star_numbers 200 --star_numbers 500 --star_numbers 1000 --star_numbers 2000 \
    --plots_folder plots/param_incomplete_40_sample_w/ \
    ${opt[$SLURM_ARRAY_TASK_ID]} \
