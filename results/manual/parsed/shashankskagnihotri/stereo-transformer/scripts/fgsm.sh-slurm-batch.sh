#!/bin/bash
#SBATCH --output=slurm/new_neurips/fgsm_vanilla_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --gres=gpu:4
#SBATCH --mem=230G
#SBATCH --time=23:59:59
#SBATCH --partition=gpu

CUDA_VISIBLE_DEVICES=0
python main_fgsm.py  --epochs 15\
                --batch_size 1\
                --checkpoint icml_fgsm\
                --pre_train\
                --num_workers 64\
                --dataset sceneflow\
                --dataset_directory /work/ws-tmp/sa058646-segment2/stereo-transformer/data/SCENE_FLOW\
                --kernel_size 3\
                --resume /work/ws-tmp/sa058646-segment2/stereo-transformer/run/sceneflow/vanilla/experiment_3/epoch_14_model.pth.tar\
                --eval\
                --fgsm\
                --epsilon $1\
                -it 1\
                -at fgsm\
                --alpha $1
