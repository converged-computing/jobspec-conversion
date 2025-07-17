#!/bin/bash
#FLUX: --job-name=evalopenclip
#FLUX: --exclusive
#FLUX: --queue=learnfair
#FLUX: -t=1500
#FLUX: --urgency=16

export MASTER_PORT='12802'
export PYTHONFAULTHANDLER='1'
export CUDA_LAUNCH_BLOCKING='0'
export HOSTNAMES='`scontrol show hostnames "$SLURM_JOB_NODELIST"`'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'
export COUNT_NODE='`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`'
export PYTHONPATH='$PYTHONPATH:$PWD/src'

export MASTER_PORT=12802
export PYTHONFAULTHANDLER=1
export CUDA_LAUNCH_BLOCKING=0
export HOSTNAMES=`scontrol show hostnames "$SLURM_JOB_NODELIST"`
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export COUNT_NODE=`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`
export PYTHONPATH="$PYTHONPATH:$PWD/src"
keep_complex_samples="False"
keep_hard="True"
source /data/home/amroabbas/projects/clipenv1/bin/activate
srun --cpu_bind=v --accel-bind=gn python -u training/main.py \
    --imagenet-val /datasets01/imagenet_full_size/061417/val \
    --model ViT-B-32 \
    --pretrained /checkpoint/amroabbas/datapruning/openclip-for-density-based-pruning/new_exps/random/amro_random_0.6_cont_Apr24/checkpoints/epoch_${SLURM_ARRAY_TASK_ID}.pt \
    --logs /checkpoint/amroabbas/datapruning/openclip-for-density-based-pruning/new_exps/eval/eval-random/amro_random_0.6 \
    --name eval_ep${SLURM_ARRAY_TASK_ID}
