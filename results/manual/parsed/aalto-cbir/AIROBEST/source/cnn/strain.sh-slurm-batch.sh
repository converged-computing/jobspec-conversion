#!/bin/bash
#FLUX: --job-name=train5
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

id -a
module purge
module load pytorch/1.4
module list
DATA_DIR=./data/TAIGA
python -u train.py -hyper_data_path ${DATA_DIR}/hyperspectral_src.pt -src_norm_multiplier ${DATA_DIR}/image_norm_l2norm_along_channel.pt -tgt_path ${DATA_DIR}/hyperspectral_tgt_normalized.pt -metadata ${DATA_DIR}/metadata.pt -hyper_data_header /scratch/project_2001284/hyperspectral/20170615_reflectance_mosaic_128b.hdr -input_normalize_method minmax_scaling -report_frequency 100 -lr 0.0001 -data_split_path ${DATA_DIR}/eelis-split13-2 -gpu 0 -epoch 150 -model PhamModel3layers4 -patch_size 45 -patch_stride 45 -batch_size 32 -save_dir S2-45_model_only_fertility_class -loss_balancing equal_weights -class_balancing focal_loss -augmentation flip -keep_best 10 -visdom_server http://puhti-login2.csc.fi/ -ignored_cls_tasks 4 5 6 7 8 -ignored_reg_tasks 0 1 2 3 4 5 6 7 8 9 10 11 12
echo -e "\n ... printing job stats .... \n"
used_slurm_resources.bash
