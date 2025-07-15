#!/bin/bash
#FLUX: --job-name=S_Cif_q
#FLUX: -t=345600
#FLUX: --priority=16

module load cudnn/7-cuda-10.0
source venv/bin/activate
cd Auto.\ Navigation/gen_models/Normalizing-flow_San/
mpiexec -n 2 python3 train.py --problem cifar10 --image_size 32 --n_level 3 --depth 32 --flow_permutation 7 --flow_coupling 2 --seed 2 --learnprior --lr 0.001 --n_bits_x 8 --epochs 2501   --restore 
