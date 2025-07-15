#!/bin/bash
#FLUX: --job-name=train_cac
#FLUX: -N=2
#FLUX: -c=2
#FLUX: --queue=gpu_high
#FLUX: -t=259200
#FLUX: --priority=16

NODE_LIST=$( scontrol show hostname $SLURM_JOB_NODELIST | sed -z 's/\n/\:4,/g' )
NODE_LIST=${NODE_LIST%?}
echo $NODE_LIST
DOWNLOADS="/work/rspandey/train_iais/downloads" ;
singularity exec --nv \
    -B $(pwd):/src \
    -B $DOWNLOADS/finetune:/storage \
    -B $DOWNLOADS/pretrained:/pretrain \
    -B $DOWNLOADS/txt_db:/txt \
    -B $DOWNLOADS/img_db:/img \
    --env NVIDIA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES \
    --pwd /src /work/rspandey/uniter.sif \
    mpirun -np $SLURM_NTASKS -H $NODE_LIST -bind-to none -map-by slot -x NCCL_DEBUG=INFO -x NCCL_SOCKET_IFNAME=^lo -x LD_LIBRARY_PATH -x PATH -mca pml ob1 -mca btl ^openib -mca btl_openib_verbose 1 python train_itm_hard_negatives.py --config config/train-siais-large.json --IAIS soft --num_train_steps 5000 --valid_steps 1000 --tsa_schedule exp_schedule
    # mpirun -np $SLURM_NTASKS -H $NODE_LIST -bind-to none -map-by slot -x NCCL_DEBUG=INFO -x NCCL_SOCKET_IFNAME=^lo -x LD_LIBRARY_PATH -x PATH -mca pml ob1 -mca btl ^openib -mca btl_openib_verbose 1 -mca btl_tcp_if_incle 192.168.0.0/16 -mca oob_tcp_if_include 192.168.0.0/16 python train_itm_hard_negatives.py --config config/train-siais-large.json --IAIS soft --num_train_steps 5000 --valid_steps 1000 --tsa_schedule exp_schedule
