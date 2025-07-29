#!/bin/bash
#FLUX: --job-name=main
#FLUX: -N=3
#FLUX: --queue=shared-gpu
#FLUX: -t=36000
#FLUX: --urgency=16

cores=20
norm_type=layer
rectify=0
block_architecture=series
version=0
for n_fixed_keys in {0,8,16}
do
name="test_fixed_keys_${n_fixed_keys}"
srun -N 1 -n 1 -c $cores -o $name.out --open-mode=append ./main_wrapper.sh --block-size 128  --version $version --eval-interval 50 --norm-type $norm_type --rectify $rectify --block-architecture $block_architecture --n-fixed-keys $n_fixed_keys --dataset stories --filepath $name.csv & 
version=$((version+1))
done
