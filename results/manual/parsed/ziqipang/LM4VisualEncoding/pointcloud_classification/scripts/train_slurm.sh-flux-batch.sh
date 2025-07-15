#!/bin/bash
#FLUX: --job-name=pointllama
#FLUX: -c=16
#FLUX: --queue=
#FLUX: -t=43200
#FLUX: --urgency=16

module reset
module load cuda/11.6.1
OMP_NUM_THREADS=16
ulimit -n 4096
conda init bash
conda activate pointbert
echo "Running"
srun python -m torch.distributed.launch \
        --master_port=4321 \
        --nproc_per_node=4 \
        main.py \
        --config $1 \
        --ckpts checkpoints/pointbert/Point-BERT.pth \
        --finetune_model \
        --exp_name $2 \
        --launcher pytorch \
        --sync_bn
