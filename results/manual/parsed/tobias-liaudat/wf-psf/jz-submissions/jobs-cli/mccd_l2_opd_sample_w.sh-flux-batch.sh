#!/bin/bash
#FLUX: --job-name=mccd_l2_sample_w
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load tensorflow-gpu/py3/2.4.1
set -x
opt[0]="--id_name _l2_opd_sample_w_2c --train_dataset_file train_Euclid_res_200_TrainStars_id_001.npy --n_epochs_param 30 30 --n_epochs_non_param 300 300"
opt[1]="--id_name _l2_opd_sample_w_5c --train_dataset_file train_Euclid_res_500_TrainStars_id_001.npy --n_epochs_param 20 20 --n_epochs_non_param 250 250"
opt[2]="--id_name _l2_opd_sample_w_1k --train_dataset_file train_Euclid_res_1000_TrainStars_id_001.npy --n_epochs_param 20 20 --n_epochs_non_param 150 150"
opt[3]="--id_name _l2_opd_sample_w_2k --train_dataset_file train_Euclid_res_2000_TrainStars_id_001.npy --n_epochs_param 15 15 --n_epochs_non_param 150 100"
cd $WORK/repo/wf-psf/jz-submissions/slurm-logs/
srun python -u ./../../long-runs/train_eval_plot_script_click.py \
    --model mccd \
    --d_max_nonparam 5 \
    --l_rate_param 0.01 0.001 \
    --l_rate_non_param 0.1 0.01 \
    --saved_model_type checkpoint \
    --saved_cycle cycle2 \
    --total_cycles 2 \
    --use_sample_weights True \
    --l2_param 5e-12 \
    --base_id_name _l2_opd_sample_w_ \
    --suffix_id_name 2c --suffix_id_name 5c --suffix_id_name 1k --suffix_id_name 2k \
    --star_numbers 200 --star_numbers 500 --star_numbers 1000 --star_numbers 2000 \
    --plots_folder plots/mccd_l2_opd_sample_w/ \
    ${opt[$SLURM_ARRAY_TASK_ID]} \
