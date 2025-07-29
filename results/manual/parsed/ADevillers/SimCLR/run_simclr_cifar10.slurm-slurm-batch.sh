#!/bin/bash
#SBATCH --job-name=expe
#SBATCH --account=xwh@v100
#SBATCH --output=./logs/expe_%j.out
#SBATCH --error=./logs/expe_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:2
#SBATCH --time=20:00:00
#SBATCH --qos=qos_gpu-t3
#SBATCH --constraint=v100-32g,ntasks-per-node=2

cd ${SLURM_SUBMIT_DIR}
module purge
module unload cuda
module load cuda/11.2
module load pytorch-gpu/py3/1.10.0
set -x
srun python src/main.py \
    --computer=jeanzay \
    --hardware=multi-gpu \
    --precision=mixed \
    --nb_workers=10 \
    --expe_name=simclr_cifar10 \
    --dataset_name=cifar10 \
    --resnet_type=resnet18 \
    --nb_epochs=800 \
    --nb_epochs_warmup=10 \
    --batch_size=512 \
    --lr_init=4.0 \
    --momentum=0.9 \
    --weight_decay=1e-6 \
    --eta=1e-3 \
    --z_dim=128 \
    --temperature_z=0.5 \
    --clsf_every=100 \
    --save_every=100 \
    --nb_epochs_clsf=90 \
    --batch_size_clsf=256 \
    --lr_init_clsf=0.2 \
    --momentum_clsf=0.9 \
    --weight_decay_clsf=0.0 \
