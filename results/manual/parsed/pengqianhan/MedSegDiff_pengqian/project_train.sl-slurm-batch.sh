#!/bin/bash
#SBATCH --job-name=diffv2_pengqian
#SBATCH --account=uoa03829
#SBATCH --mail-user=phan635@aucklanduni.ac.nz
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=50G
#SBATCH --time=1-06:00:00

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
srun python /nesi/project/uoa03829/phan635/NeSI-Project-Template/MedSegDiff_pengqian/scripts/segmentation_train.py --data_dir /nesi/project/uoa03829/BraTS2023Dataset --out_dir ../output --image_size 256 --num_channels 128 --class_cond False --num_res_blocks 2 --num_heads 1 --learn_sigma True --use_scale_shift_norm False --attention_resolutions 16 --diffusion_steps 1000 --noise_schedule linear --rescale_learned_sigmas False --rescale_timesteps False --lr 1e-4 --batch_size 8
