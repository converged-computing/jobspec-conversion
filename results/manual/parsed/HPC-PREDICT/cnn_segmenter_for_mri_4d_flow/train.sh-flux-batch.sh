#!/bin/bash
#FLUX: --job-name=quirky-egg-9950
#FLUX: --urgency=16

source /usr/bmicnas01/data-biwi-01/nkarani/softwares/anaconda/installation_dir/bin/activate tf_v1_15
python /usr/bmicnas01/data-biwi-01/nkarani/projects/hpc_predict/code/code/hpc-predict/segmenter/cnn_segmenter_for_mri_4d_flow/train.py \
--training_input '/usr/bmicnas01/data-biwi-01/nkarani/projects/hpc_predict/data/eth_ibt/flownet/pollux/all_data/training_data.hdf5' \
--training_output '/usr/bmicnas01/data-biwi-01/nkarani/projects/hpc_predict/code/code/hpc-predict/segmenter/cnn_segmenter_for_mri_4d_flow/logdir/'
echo "Hostname was: `hostname`"
echo "Reached end of job file."
