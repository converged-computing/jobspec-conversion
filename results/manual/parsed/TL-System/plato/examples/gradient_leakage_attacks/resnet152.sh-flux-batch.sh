#!/bin/bash
#FLUX: --job-name=bloated-chair-3120
#FLUX: -c=12
#FLUX: -t=36000
#FLUX: --urgency=16

./../../run -c fedavg_resnet152_cifar100.yml
