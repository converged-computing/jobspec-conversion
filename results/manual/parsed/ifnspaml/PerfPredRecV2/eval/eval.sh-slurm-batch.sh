#!/bin/bash
#SBATCH --job-name=attack-val-dl
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1080:1
#SBATCH --mem=20000M
#SBATCH --time=10:20:00
#SBATCH --partition=gpu,gpub
#SBATCH --exclude=gpu06,gpu05

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
