#!/bin/bash
#FLUX: --job-name=celeba_train
#FLUX: -c=16
#FLUX: --queue=datasci
#FLUX: --urgency=16

cd ..
python train_lenet_.py --dataset celeba --seed 2018 --n_classes 2 \
--save --target celeba_resnet50_10.pkl --round 10
