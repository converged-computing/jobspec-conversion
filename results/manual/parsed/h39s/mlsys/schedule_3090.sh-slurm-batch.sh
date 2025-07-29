#!/bin/bash
#SBATCH --job-name=config_3090_6
#SBATCH --output=sch_logs/config_3090_6.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:3090:1
#SBATCH --mem=64GB
#SBATCH --time=10:00:00

nvidia-smi
ifconfig | grep -o 'inet [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'
echo $TOKENIZERS_PARALLELISM
source /home/amangupt/anaconda3/etc/profile.d/conda.sh
conda activate mls
python3 run_benchmark.py config/config_3090_6.yaml
