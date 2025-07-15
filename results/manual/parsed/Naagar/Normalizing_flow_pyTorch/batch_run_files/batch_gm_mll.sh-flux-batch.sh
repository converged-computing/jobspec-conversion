#!/bin/bash
#FLUX: --job-name=dirty-milkshake-4996
#FLUX: -t=345600
#FLUX: --urgency=16

module load cudnn/7-cuda-10.0
source venv/bin/activate
cd Auto.\ Navigation/gen_models/Normalizing-flow-master/
mpiexec -n 4 python3 train.py --problem imagenet-oord --image_size 32 --n_level 3 --depth 48 --flow_permutation 3 --flow_coupling 1 --seed 0 --learnprior --lr 0.001 --n_bits_x 8 --data_dir $DATA_PATH
