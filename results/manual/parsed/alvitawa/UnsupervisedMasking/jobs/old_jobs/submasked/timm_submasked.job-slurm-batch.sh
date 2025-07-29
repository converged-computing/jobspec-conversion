#!/bin/bash
#FLUX: --job-name=TRAIN
#FLUX: -c=3
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

source load.sh
srun python3 main.py --multirun main.model=timm dl.epochs=100 main.dataset=cifar10pgn dl.optimizer=sgd dl.lr=0.1 dl.momentum=0.9 dl.batch_size=128 dl.weight_decay=0.0005 dl.scheduler=cosine model.timm.name=resnet18 model.timm.init_scores_mean=1.0 main.dataset=flowers
