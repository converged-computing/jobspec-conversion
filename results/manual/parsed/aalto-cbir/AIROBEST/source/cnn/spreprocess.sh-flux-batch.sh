#!/bin/bash
#FLUX: --job-name=gassy-leopard-3453
#FLUX: --urgency=16

module purge
module load pytorch
module list
SAVE_DIR=new_TAIGA
HYP_IMAGE=20170615_reflectance_mosaic_128b.hdr
python -u preprocess.py --data_dir /scratch/project_2001284/hyperspectral --save_dir $SAVE_DIR --hyperspec $HYP_IMAGE --forestdata forestdata_stands.hdr --src_file_name hyperspectral_src --tgt_file_name hyperspectral_tgt_normalized --metadata_file_name metadata --normalize_method l2norm_along_channel --ignore_zero_labels --remove_bad_data --label_normalize_method clip
            #--hyperspec_bands 0:110
echo -e "\n ... printing job stats .... \n"
used_slurm_resources.bash
