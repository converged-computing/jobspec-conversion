#!/bin/bash
#FLUX: --job-name=deepstem50
#FLUX: -c=10
#FLUX: --queue=3090
#FLUX: -t=259200
#FLUX: --urgency=16

export WANDB_SPAWN_METHOD='fork'

cd $SLURM_SUBMIT_DIR
echo "SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR"
echo "CUDA_HOME=$CUDA_HOME"
echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
echo "CUDA_VERSION=$CUDA_VERSION"
srun -l /bin/hostname
srun -l /bin/pwd
srun -l /bin/date
echo "Start"
export WANDB_SPAWN_METHOD=fork
date
nvidia-smi
python train_AL_voc.py -p checkpoint/deepstem50_ppredpwr_coff12_voc_mul_lr_0.00001_dbtrim5 \
--model deeplabv3pluswn_resnet50deepstem \
--init_checkpoint checkpoint/res50wndeepstem_imagenet_pretrained.tar \
--method active_joint_multi_lossdecomp \
--active_method my_bvsb_predclsbal_pwr \
--cls_weight_coeff 12.0 \
--or_labeling \
--fair_counting \
--loss_type joint_multi_loss \
--nseg 150 \
--scheduler poly \
--separable_conv \
--train_lr 0.00001 \
--start_over \
--num_workers 12 \
--finetune_itrs 30000 \
--val_period 2500 \
--val_start 0 \
--max_iterations 5 \
--train_transform rescale_513_multi_notrg \
--loader region_voc_or_tensor \
--wandb_tags 10k,base,cos \
--active_selection_size 10000 \
--multi_ce_temp 0.1 \
--group_ce_temp 0.1 \
--ce_temp 0.1 \
--coeff 16.0 \
--coeff_mc 8.0 \
--coeff_gm 1.0 \
--trim_kernel_size 5 \
--trim_multihot_boundary \
--cls_weight_coeff 12.0 \
--init_iteration 1
