#!/bin/bash
#FLUX: --job-name=pt_train
#FLUX: -c=64
#FLUX: --gpus-per-task=4
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module --force purge; module load modules/2.2-20230808
module load slurm gcc cmake cuda/12.1.1 cudnn/8.9.2.26-12.x nccl openmpi apptainer
nvidia-smi
source ~/miniconda3/bin/activate pytorch
which python3
python3 --version
echo 'Starting training.'
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 python3 -u mlpf/pyg_pipeline.py --train \
    --config $1 \
    --prefix $2 \
    --gpus 8 \
    --gpu-batch-multiplier 4 \
    --num-workers 1 \
    --prefetch-factor 2 \
    --checkpoint-freq 1 \
    --comet
echo 'Training done.'
