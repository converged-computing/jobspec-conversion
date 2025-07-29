#!/bin/bash
#SBATCH --job-name=siampose
#SBATCH --output=siampose_ct
#SBATCH --error=siampose_cterr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --nodelist=node6

export PYTHONPATH='$ROOT:$PYTHONPATH'

date
module load anaconda3/5.3.0 cuda/9.0 cudnn/7.3.0
source activate pytorch0.4
ROOT=/cluster/home/it_stu1/bdclub/SiamRCNN/
export PYTHONPATH=$ROOT:$PYTHONPATH
mkdir -p logs
python -u $ROOT/tools/train_siamrcnn.py \
    --config=config.json -b 1 \
    -j 8 --pretrain ../siampose_ct/checkpoint_e245.pth \
    --epochs 200 \
    --log logs/log.txt \
    2>&1 | tee logs/train.log
