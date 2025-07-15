#!/bin/bash
#FLUX: --job-name=LrgSklCNN
#FLUX: -N=3
#FLUX: -c=6
#FLUX: --urgency=16

export WORLD_SIZE='12'
export MASTER_PORT='12346'
export MASTER_ADDR='$master_addr'

export WORLD_SIZE=12
export MASTER_PORT=12346
echo "NODELIST="${SLURM_NODELIST}
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
source ~/.bashrc
conda activate plifs
ip1=`hostname -I | awk '{print $1}'`
echo $ip1
echo "tcp://${ip1}:${MASTER_PORT}"
CUDA_VISIBLE_DEVICES=0,1,2,3
python -u -m torch.distributed.launch \
    --nnodes=3 \
    --master_addr=$ip1 \
    --nproc_per_node=4 \
    --master_port=2334 \
    main_distributed.py --multiprocessing-distributed --dist-file dist_file --dist-backend nccl 
