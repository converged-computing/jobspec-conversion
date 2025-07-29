#!/bin/bash
#FLUX: --job-name=poly_sample_w_bis1_
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load tensorflow-gpu/py3/2.4.1
set -x
opt[0]="--id_name _sample_w_bis1_2c --train_dataset_file train_Euclid_res_200_TrainStars_id_001.npy --n_epochs_param 30 30 --n_epochs_non_param 300 300"
opt[1]="--id_name _sample_w_bis1_5c --train_dataset_file train_Euclid_res_500_TrainStars_id_001.npy --n_epochs_param 30 30 --n_epochs_non_param 200 150"
opt[2]="--id_name _sample_w_bis1_1k --train_dataset_file train_Euclid_res_1000_TrainStars_id_001.npy --n_epochs_param 20 20 --n_epochs_non_param 150 100"
opt[3]="--id_name _sample_w_bis1_2k --train_dataset_file train_Euclid_res_2000_TrainStars_id_001.npy --n_epochs_param 15 15 --n_epochs_non_param 100 50"
cd $WORK/repo/wf-psf/long-runs/
srun python -u ./train_eval_plot_script_click.py \
    --model poly \
    --d_max_nonparam 5 \
    --l_rate_param 0.01 0.004 \
    --l_rate_non_param 0.1 0.06 \
    --saved_model_type checkpoint \
    --saved_cycle cycle2 \
    --total_cycles 2 \
    --use_sample_weights True \
    --l2_param 0. \
    --base_id_name _sample_w_bis1_ \
    --suffix_id_name 2c --suffix_id_name 5c --suffix_id_name 1k --suffix_id_name 2k \
    --star_numbers 200 --star_numbers 500 --star_numbers 1000 --star_numbers 2000 \
    --plots_folder plots/poly_sample_w_bis1/ \
    ${opt[$SLURM_ARRAY_TASK_ID]} \
