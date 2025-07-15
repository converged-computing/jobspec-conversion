#!/bin/bash
#FLUX: --job-name=diffv2_pengqian
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=108000
#FLUX: --urgency=16

export PYTHONNOUSERSITE='1'
export NCCL_DEBUG='INFO '

module purge
module load CUDA/11.6.2
module load Miniconda3/22.11.1-1
source $(conda info --base)/etc/profile.d/conda.sh
export PYTHONNOUSERSITE=1
nvidia-smi
echo "CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES}"
conda deactivate
conda activate ./venv
which python
export NCCL_DEBUG=INFO 
srun python /nesi/project/uoa03829/phan635/NeSI-Project-Template/MedSegDiff_pengqian/scripts/segmentation_sample_brats.py --data_dir /nesi/project/uoa03829/BraTS2023Dataset/ASNR-MICCAI-BraTS2023-GLI-Challenge-ValidationData/ASNR-MICCAI-BraTS2023-GLI-Challenge-ValidationData   --out_dir /nesi/project/uoa03829/phan635/GLI_sample_folder_seg  --model_path /nesi/project/uoa03829/phan635/output/savedmodel015000.pt --image_size 256 --num_channels 128 --class_cond False --num_res_blocks 2 --num_heads 1 --learn_sigma True --use_scale_shift_norm False --attention_resolutions 16 --diffusion_steps 1000 --noise_schedule linear --rescale_learned_sigmas False --rescale_timesteps False --num_ensemble 25  --dpm_solver True 
