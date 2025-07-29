#!/bin/bash
#FLUX: --job-name=proxy_distribution
#FLUX: -N=8
#FLUX: -c=8
#FLUX: -t=172800
#FLUX: --urgency=16

export WORLD_SIZE='16 # set it equal to total number of gpus across all nodes (=total number of tasks across all nodes)'
export MASTER_ADDR='$master_addr'
export MASTER_PORT='8120'

export WORLD_SIZE=16 # set it equal to total number of gpus across all nodes (=total number of tasks across all nodes)
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
export MASTER_PORT=8120
echo "NODELIST="${SLURM_JOB_NODELIST}
echo "MASTER_ADDR="$MASTER_ADDR
echo $(date '+%d/%m/%Y %H:%M:%S')
for node in $(scontrol show hostnames $SLURM_JOB_NODELIST)
do
    ssh $node
    mkdir /scratch/serialized/
    echo "moving data to scratch on node ${node}"
    cp -r /scratch/gpfs/vvikash/synthetic_robustness/synthetic_dataset/diffusion/serialized/* /scratch/serialized/
    echo "moved data to scratch on node ${node}"
done
module load anaconda3/2020.11
source activate py37 # use your conda environment
echo $CUDA_VISIBLE_DEVICES
srun python train.py --dataset cifar10 --arch resnest152 --data-dir /tigress/vvikash/datasets/all_cifar10/cifar10_pytorch/ \
    --trainer pgd --val-method pgd --batch-size 256 --batch-size-syn 256 --lr 0.2 --syn-data-list ddpm_cifar10 \
    --syn-data-dir /scratch/serialized/ --exp-name cifar10_resnest152_pgd_advtrain_ddpm_cifar10_serialized
