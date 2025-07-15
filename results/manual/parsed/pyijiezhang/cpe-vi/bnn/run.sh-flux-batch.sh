#!/bin/bash
#FLUX: --job-name=mfvi
#FLUX: -n=2
#FLUX: -t=21600
#FLUX: --priority=16

source ~/miniconda3/etc/profile.d/conda.sh
conda activate bayesianize
lambs=(1.0)
prior_scale=1.0
aug=1
annealing_epochs_1=0
annealing_epochs_2=40
for lamb in ${lambs[*]}; do
    python scripts/cifar_resnet.py --project_name="mfvi_cifar10_resnet18" \
                                --obj="elbo" \
                                --lamb=$lamb \
                                --prior_scale=$prior_scale \
                                --aug=$aug \
                                --num_epochs=100 \
                                --annealing_epochs=$annealing_epochs_1 \
                                --lr=0.001 \
                                --batch_size=128 \
                                --resnet=18 \
                                --cifar=10 &
    python scripts/cifar_resnet.py --project_name="mfvi_cifar10_resnet18" \
                                --obj="elbo" \
                                --lamb=$lamb \
                                --prior_scale=$prior_scale \
                                --aug=$aug \
                                --num_epochs=100 \
                                --annealing_epochs=$annealing_epochs_2 \
                                --lr=0.001 \
                                --batch_size=128 \
                                --resnet=18 \
                                --cifar=10 &
    wait
done
