#!/bin/bash
#FLUX: --job-name=ablate_kitti
#FLUX: -c=12
#FLUX: --queue=gpu_p2
#FLUX: -t=71940
#FLUX: --priority=16

module purge
conda deactivate
module load pytorch-gpu/py3/1.7.1
python $WORK/code/xmuda-extend/xmuda/train_2d_proj3d2d.py batch_size=4 n_gpus=4 enable_log=true exp_prefix=ManualGroup16 project_scale=2 project_1_2=true project_1_4=true project_1_8=true project_1_16=false run=3 dataset=kitti project_scale=2 class_proportion_loss=true frustum_size=8 virtual_img=false context_prior=CRCP weight_decay=0 optimize_iou=true MCA_ssc_loss=true CE_relation_loss=true n_relations=16 corenet_proj=null
