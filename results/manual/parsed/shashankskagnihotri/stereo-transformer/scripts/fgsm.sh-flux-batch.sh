#!/bin/bash
#FLUX: --job-name=misunderstood-bits-5598
#FLUX: -c=64
#FLUX: --queue=gpu
#FLUX: -t=86399
#FLUX: --urgency=16

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
