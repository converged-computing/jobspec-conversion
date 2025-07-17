#!/bin/bash
#FLUX: --job-name=attack-val-dl
#FLUX: -c=4
#FLUX: --queue=gpu,gpub
#FLUX: -t=37200
#FLUX: --urgency=16

export IFN_DIR_DATASET='/beegfs/data/shared'
export IFN_DIR_CHECKPOINT='${PWD}/../../../experiments_code-release/'
export PYTHONPATH='${PYTHONPATH}:/beegfs/work/kusuma/papers/cvpr2023/code_release/PerfPredRecV2/'

export IFN_DIR_DATASET=/beegfs/data/shared
export IFN_DIR_CHECKPOINT="${PWD}/../../../experiments_code-release/"
export PYTHONPATH=/beegfs/work/kusuma/papers/cvpr2023/code_release/
export PYTHONPATH="${PYTHONPATH}:/beegfs/work/kusuma/papers/cvpr2023/code_release/PerfPredRecV2/"
conda activate swiftnet-pp-v2
python eval_attacks_n_noise.py \
--model_name SwiftNetRec \
--encoder resnet18 \
--rec_decoder swiftnet \
--model_state_name swiftnet_rn18 \
--weights_epoch 10 \
--dataset cityscapes \
--subset val \
--num_workers 2 \
--zeroMean 1 \
--epsilon 0 0.25 0.5 1 2 4 8 12 16 20 24 28 32 \
