#!/bin/bash
#FLUX --job-name=faux-underoos-2043
#FLUX -c=12
#FLUX -t=36000
#FLUX --urgency=16

./../../run -c fedavg_resnet152_cifar100.yml
