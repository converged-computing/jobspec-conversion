#!/bin/bash
#SBATCH --job-name=bdd_source_and_labeled_075
#SBATCH --output=gypsum/logs/%j_bdd_source_and_labeled_075.txt
#SBATCH --error=gypsum/errs/%j_bdd_source_and_labeled_075.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --mem=100000

python tools/train_net_step.py \
    --dataset bdd_peds+labeled_075 \
    --cfg configs/baselines/bdd_peds_dets_bs64_4gpu.yaml  \
    --set NUM_GPUS 1 TRAIN.SNAPSHOT_ITERS 5000 \
    --iter_size 2 \
    --use_tfboard \
    --load_ckpt /mnt/nfs/work1/elm/arunirc/Research/detectron-video/detectron_distill/Detectron-pytorch-video/Outputs/e2e_faster_rcnn_R-50-C4_1x/Jul30-15-51-27_node097_step/ckpt/model_step79999.pth \
    #--load_ckpt /mnt/nfs/scratch1/pchakrabarty/ped_models/bdd_peds.pt \
