#!/bin/bash
#FLUX: --job-name=t_eval
#FLUX: --urgency=16

srun --mpi=pmix --gpus=1 --container-image=/users/rosenbaum/aheidar/containers/tensorflow:21.07-tf2-py3.sqsh --container-save=/users/rosenbaum/aheidar/containers/tensorflow:21.07-tf2-py3.sqsh --container-mounts=/users/rosenbaum/aheidar/code/ViewFormer:/mnt/ViewFormer --pty /bin/bash -c "python /mnt/ViewFormer/viewformer/cli.py evaluate transformer --codebook-model "/mnt/ViewFormer/sm7-codebook-v5/last.ckpt" --transformer-model "/mnt/ViewFormer/sm7-transformer-training/weights.model.099-last" --loader-path "/mnt/ViewFormer/datasets/sm7" --loader dataset --loader-split test --batch-size 1 --image-size 128 --num-eval-images 1000 --job-dir "/mnt/ViewFormer/sm7-transformer-evaluation-v5" "
