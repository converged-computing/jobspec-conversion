#!/bin/bash
#FLUX: --job-name=04b_asset_RS_within
#FLUX: --queue=gpu
#FLUX: -t=100800
#FLUX: --urgency=16

module load anaconda3
module load cuda
source activate dl_env # Or whatever you called your environment.
echo "Submitting job with sbatch from directory: ${SLURM_SUBMIT_DIR}"
echo "Home directory: ${HOME}"
echo "Working directory: $PWD"
echo "Current node: ${SLURM_NODELIST}"
python --version
python -m torch.utils.collect_env
nvcc -V
echo " "
echo " "
echo "============================================================================================"
echo "Training Output"
echo "============================================================================================"
echo " "
model_name='within_asset_RS'
cv_object_name='within_asset_RS_cv'
target_var='mean_asset_index_yeh'
data_type='RS_v2'
id_var='delta_id'
img_folder='RS_v2_delta'
stats_file='RS_v2_delta_img_stats.pkl'
resnet_params='{"input_channels": 3, "use_pretrained_weights":false, "scaled_weight_init":false}'
python -u dl_02_within_train_demean.py "$model_name" "$cv_object_name" "$target_var" "$data_type" "$id_var" "$img_folder" "$stats_file" "$resnet_params"
echo " "
echo "============================================================================================"
echo "Training completed"
echo "============================================================================================"
echo " "
