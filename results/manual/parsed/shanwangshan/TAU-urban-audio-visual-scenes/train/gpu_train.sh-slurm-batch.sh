#!/bin/bash
#SBATCH --job-name=av
#SBATCH --output=out_av.txt
#SBATCH --error=err_av.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=8000
#SBATCH --time=3-00:00:00

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/home/wang9/.conda/envs/torch_env/lib/'

source activate torch_env
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/wang9/.conda/envs/torch_env/lib/
python train.py --features_path '../create_data/features_data/' --model_type 'audio_video'
