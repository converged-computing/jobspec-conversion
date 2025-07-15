#!/bin/bash
#FLUX: --job-name=evasive-citrus-9424
#FLUX: -c=12
#FLUX: -t=36000
#FLUX: --priority=16

./../../run -c fedavg_resnet152_cifar100.yml
