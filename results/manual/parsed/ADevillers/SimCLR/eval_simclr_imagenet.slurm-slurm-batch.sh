#!/bin/bash
#SBATCH --job-name=expe
#SBATCH --account=xwh@v100
#SBATCH --output=./logs/expe_%j.out
#SBATCH --error=./logs/expe_%j.err
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:4
#SBATCH --time=20:00:00
#SBATCH --qos=qos_gpu-t3
#SBATCH --constraint=v100-32g,ntasks-per-node=4

cd ${SLURM_SUBMIT_DIR}
module purge
module unload cuda
module load cuda/11.2
module load pytorch-gpu/py3/1.10.0
set -x
srun python src/eval.py \
    --computer=jeanzay \
    --hardware=multi-gpu \
    --precision=mixed \
    --nb_workers=10 \
    --dataset_name=imagenet \
    --resnet_type=resnet50 \
    --z_dim=128 \
    --nb_epochs_clsf=90 \
    --batch_size_clsf=256 \
    --lr_init_clsf=0.2 \
    --momentum_clsf=0.9 \
    --weight_decay_clsf=0.0 \
    --checkpoint=./checkpoints/weights_simclr_imagenet.pt \
