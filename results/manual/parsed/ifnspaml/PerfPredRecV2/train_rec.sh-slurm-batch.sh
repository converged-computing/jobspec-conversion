#!/bin/bash
#FLUX: --job-name=trn_SNR
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=4800
#FLUX: --urgency=16

export IFN_DIR_DATASET='/beegfs/data/shared'
export IFN_DIR_CHECKPOINT='${PWD}/../../experiments/'

export IFN_DIR_DATASET=/beegfs/data/shared
export IFN_DIR_CHECKPOINT="${PWD}/../../experiments/"
conda activate swiftnet-pp-v2
python train_swiftnet_rec.py \
--model_name SwiftNetRec \
--encoder resnet18 \
--savedir swiftnet-rn18 \
--dataset cityscapes \
--zeromean 1 \
--batch_size_train 8 \
--num_epochs 10 \
--rec_decoder swiftnet \
--lateral 1 \
--load_model_state_name ../SwiftNet/swiftnet_baseline/
