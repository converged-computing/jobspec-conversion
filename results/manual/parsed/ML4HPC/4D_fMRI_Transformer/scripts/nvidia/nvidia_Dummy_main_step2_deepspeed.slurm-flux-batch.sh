#!/bin/bash
#FLUX: --job-name=lovely-hope-1556
#FLUX: -c=2
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

export OMPI_MCA_btl_openib_warn_default_gid_prefix='0'
export OMPI_MCA_btl_openib_cpc_exclude='rdmacm'
export OMPI_MCA_btl_openib_if_exclude='mlx5_5:1,mlx5_11'
export NCCL_SOCKET_IFNAME='hsn'

set +x
singularity run --nv /home/be62tdqc/test.sif
sleep 10
export OMPI_MCA_btl_openib_warn_default_gid_prefix=0
export OMPI_MCA_btl_openib_cpc_exclude=rdmacm
export OMPI_MCA_btl_openib_if_exclude=mlx5_5:1,mlx5_11
env | grep SLURM
export NCCL_SOCKET_IFNAME=hsn
srun -u bash -c "
source export_DDP_vars.sh 
nsys profile -t cuda,nvtx,cublas,cudnn -f true -o output_%p /home/be62tdqc/.local/bin/deepspeed main_deepspeed.py --image_path /pscratch/sd/s/stella/ABCD_TFF/MNI_to_TRs --step 2 --dataset_name Dummy --profiling --batch_size_phase2 4 --random_TR --lr_init_phase2 1e-4 --lr_policy_phase2 SGDR --lr_warmup_phase2 500 --lr_gamma_phase2 0.5 --lr_step_phase2 500 --exp_name SGDR --deepspeed --deepspeed_config ds_config.json --exp_name deepspeed_dummy
" 
