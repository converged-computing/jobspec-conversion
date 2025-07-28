#!/bin/bash
#FLUX: --job-name=train_resnet
#FLUX: -c=4
#FLUX: --queue=studentbatch
#FLUX: -t=43200
#FLUX: --urgency=16

python run_func_OCD.py -e 0 -pb ./base_models/resnet20.pt -pc ./configs/train_resnet.json -pdtr ./data/cifar10 -pdts ./data/cifar10 -dt resnet -prc 0
