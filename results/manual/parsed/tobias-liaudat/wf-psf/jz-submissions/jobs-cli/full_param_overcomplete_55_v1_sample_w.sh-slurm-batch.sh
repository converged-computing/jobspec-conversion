#!/bin/bash
#SBATCH --job-name=param_overcomplete_55_v1_sample_w
#SBATCH --account=ynx@gpu
#SBATCH --output=param_overcomplete_55_v1_sample_w_%j.out
#SBATCH --error=param_overcomplete_55_v1_sample_w_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --constraint=ntasks-per-node=1,v100-32g
#SBATCH --array=0-3

module purge
module load tensorflow-gpu/py3/2.4.1
set -x
opt[0]="--id_name _overcomplete_55_v1_sample_w_2c --train_dataset_file train_Euclid_res_200_TrainStars_id_001.npy --n_epochs_param 40 40 --l_rate_param 0.005 0.001"
opt[1]="--id_name _overcomplete_55_v1_sample_w_5c --train_dataset_file train_Euclid_res_500_TrainStars_id_001.npy --n_epochs_param 30 30 --l_rate_param 0.005 0.001"
opt[2]="--id_name _overcomplete_55_v1_sample_w_1k --train_dataset_file train_Euclid_res_1000_TrainStars_id_001.npy --n_epochs_param 30 30 --l_rate_param 0.005 0.001"
opt[3]="--id_name _overcomplete_55_v1_sample_w_2k --train_dataset_file train_Euclid_res_2000_TrainStars_id_001.npy --n_epochs_param 20 20 --l_rate_param 0.005 0.001"
cd $WORK/repo/wf-psf/long-runs/
srun python -u ./train_eval_plot_script_click.py \
    --model param \
    --n_zernikes 55 \
    --saved_model_type checkpoint \
    --saved_cycle cycle2 \
    --total_cycles 2 \
    --use_sample_weights True \
    --l2_param 0. \
    --base_id_name _overcomplete_55_v1_sample_w_ \
    --suffix_id_name 2c --suffix_id_name 5c --suffix_id_name 1k --suffix_id_name 2k \
    --star_numbers 200 --star_numbers 500 --star_numbers 1000 --star_numbers 2000 \
    --plots_folder plots/param_overcomplete_55_v1_sample_w/ \
    ${opt[$SLURM_ARRAY_TASK_ID]} \
