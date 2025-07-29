#!/bin/bash
#SBATCH --job-name=trn_SNR
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1080:1
#SBATCH --mem=20000M
#SBATCH --time=01:20:00
#SBATCH --partition=gpu

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
