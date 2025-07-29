#!/bin/bash
#SBATCH --job-name=large
#SBATCH --output=logs/large.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=16GB
#SBATCH --time=11:30:00

echo $SLURMD_NODENAME $CUDA_VISIBLE_DEVICES
. /etc/profile.d/modules.sh
eval "$(conda shell.bash hook)"
nvidia-smi
conda activate /home/nkx870/anaconda3/envs/monorama
for language in fr
do
    python3.9 French.py --language $language --model_size large
done
