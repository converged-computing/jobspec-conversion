#!/bin/bash
#FLUX: --job-name=outstanding-house-5269
#FLUX: --queue=mcs.gpu.q
#FLUX: -t=864000
#FLUX: --urgency=16

module load cuda10.2
python $1multiproc.py --nproc_per_node 2 $1main_individual.py --sparse_init ERK --filename results --multiplier 1 --growth gradient --seed 17 --master_port 4545 -j5 -p 500 --arch resnet50 -c fanin --update_frequency 4000 --label-smoothing 0.1 -b 64 --lr 0.1 --warmup 5 --epochs 100 --density 0.2 $2 ../../data/ImageNet/
source deactivate
