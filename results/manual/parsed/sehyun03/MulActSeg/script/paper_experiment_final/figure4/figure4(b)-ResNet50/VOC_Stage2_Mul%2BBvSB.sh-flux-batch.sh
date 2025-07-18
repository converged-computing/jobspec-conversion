#!/bin/bash
#FLUX: --job-name=stage2
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
round=1
save_path=checkpoint/ms_deepstem50_bvsb_dbdry_stage2_lr00002_nopredignore_voc
checkpoint_path=checkpoint/deepstem50_dbtim_voc_mul_lr_0.00001_trim5_my_bvsb_sp150_nlbl10.0k_iter30.0k_method-active_joint_multi_lossdecomp-_coeff16.0_ignFalse_lr1e-05__1
lr=0.00001
python eval_AL_voc.py -p "$checkpoint_path" \
--stage2 \
--datalist_path "$checkpoint_path"/datalist_0"$round".pkl \
--init_checkpoint "$checkpoint_path"/checkpoint0"$round".tar \
--resume_checkpoint "$checkpoint_path"/checkpoint0"$round".tar \
--method eval_save_cosplbl_prop_includeonehot_voc_ms \
--or_labeling \
--train_transform eval_spx_identity_ms \
--loader eval_region_voc_all_ms \
--trim_multihot_boundary \
--trim_kernel_size 5 \
--nseg 150 \
--model deeplabv3pluswn_resnet50deepstem \
--separable_conv \
--val_batch_size 1 \
--wandb_tags eval \
--num_workers 8 \
--dontlog
python train_stage2_AL_voc.py -p "$save_path" \
--stage2 \
--init_iteration "$round" \
--datalist_path "$checkpoint_path"/datalist_0"$round".pkl \
--resume_checkpoint "$checkpoint_path"/checkpoint0"$round".pkl \
--init_checkpoint checkpoint/res50wndeepstem_imagenet_pretrained.tar \
--finetune_itrs 30000 \
--val_period 2500 \
--val_start 0 \
--active_selection_size 10000 \
--loader region_voc_plbl \
--train_transform rescale_513_notrg \
--model deeplabv3pluswn_resnet50deepstem \
--separable_conv \
--optimizer adamw \
--train_lr "$lr" \
--ce_temp 0.1 \
--cls_lr_scale 10.0 \
--scheduler poly \
--train_batch_size 4 \
--num_workers 10 \
--val_batch_size 4 \
--nseg 150 \
--dominant_labeling \
--method active \
--plbl_type "ms" \
--wandb_tags 10k base cos
