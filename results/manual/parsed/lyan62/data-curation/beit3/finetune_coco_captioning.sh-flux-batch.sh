#!/bin/bash
#FLUX: --job-name=beit3_coco
#FLUX: -c=24
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

export PYTHONPATH='/home/rdp455/unilm/beit3'
export WANDB_API_KEY='7ff3068098020a220faf94a829699f6197bb1128'
export WANDB_PROJECT='beit3'
export MODEL_NAME='coco-caption-base'
export PL_TORCH_DISTRIBUTED_BACKEND='gloo'
export SEED='42'
export NODE_RANK='0'
export MASTER_ADDR=''

echo $SLURMD_NODENAME $CUDA_VISIBLE_DEVICES
export PYTHONPATH=/home/rdp455/unilm/beit3
export WANDB_API_KEY=7ff3068098020a220faf94a829699f6197bb1128
export WANDB_PROJECT=beit3
export MODEL_NAME="coco-caption-base"
export PL_TORCH_DISTRIBUTED_BACKEND=gloo
export SEED=42
eval "$(conda shell.bash hook)"
source activate beit3
module load cuda/11.3
nvidia-smi
python -c "import torch; print(torch.__version__)"
cd /home/rdp455/unilm/beit3
export NODE_RANK=0
export MASTER_ADDR=
OMP_NUM_THREADS=1 torchrun --standalone --nnodes=1 --nproc_per_node=4 run_beit3_finetuning.py \
        --model beit3_base_patch16_480 \
        --input_size 480 \
        --task coco_captioning \
        --batch_size 32 \
        --update_freq 2 \
        --layer_decay 1.0 \
        --lr 4e-5 \
        --randaug \
        --epochs 10 \
        --warmup_epochs 1 \
        --drop_path 0.1 \
        --sentencepiece_model /projects/nlp/people/rdp455/beit3/pretrained_model/beit3.spm \
        --finetune /projects/nlp/people/rdp455/beit3/pretrained_model/beit3_base_patch16_224.pth \
        --data_path /projects/nlp/people/rdp455/beit3_data/ \
        --output_dir /home/rdp455/unilm/beit3/output/bz32_gacc2 \
        --log_dir /home/rdp455/unilm/beit3/log \
        --weight_decay 0.05 \
        --seed 42 \
        --save_ckpt_freq 5 \
        --num_max_bpe_tokens 32 \
        --captioning_mask_prob 0.7 \
        --drop_worst_after 12000 \
        --dist_eval \
        --checkpoint_activations \
        --enable_deepspeed
