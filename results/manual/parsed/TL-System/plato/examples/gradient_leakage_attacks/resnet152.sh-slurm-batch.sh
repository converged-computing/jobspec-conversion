#!/bin/bash
#FLUX: --job-name=outstanding-animal-3961
#FLUX: -c=12
#FLUX: -t=36000
#FLUX: --urgency=16

./../../run -c fedavg_resnet152_cifar100.yml
