#!/bin/bash
#SBATCH --job-name=fn_adv
#SBATCH --output=finetune_advanced-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=0
#SBATCH --time=23:00:00
#SBATCH: --exclusive
#SBATCH --constraint=A100
#SBATCH: --no-requeue

export LD_LIBRARY_PATH='/usr/local/cuda/lib64:/share/apps/cudnn_8_1_0/cuda/lib64'

pwd; hostname; date
nvidia-smi
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/share/apps/cudnn_8_1_0/cuda/lib64
echo $LD_LIBRARY_PATH
REPO_LOC=/share/nas2/walml/repos/zoobot
/share/nas2/walml/miniconda3/envs/zoobot/bin/python /share/nas2/walml/repos/zoobot/zoobot/tensorflow/examples/finetune_advanced.py \
    --batch-size 512 \
    --epochs 50
