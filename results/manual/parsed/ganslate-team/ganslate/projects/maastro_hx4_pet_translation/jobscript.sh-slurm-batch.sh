#!/bin/bash
#SBATCH --job-name=hx4_pet_pix2pix
#SBATCH --output=/home/zk315372/Chinmay/Git/ganslate/projects/maastro_hx4_pet_translation/slurm_logs/%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:pascal:2
#SBATCH --mem=4G
#SBATCH --time=05:00:00

module load cuda
echo; echo
nvidia-smi
echo; echo
python_interpreter="/home/zk315372/miniconda3/envs/gan_env/bin/python3"
training_file="/home/zk315372/Chinmay/Git/ganslate/tools/train.py"
config_file="/home/zk315372/Chinmay/Git/ganslate/projects/maastro_hx4_pet_translation/experiments/pix2pix.yaml"
CUDA_VISIBLE_DEVICES=0 $python_interpreter $training_file config=$config_file
