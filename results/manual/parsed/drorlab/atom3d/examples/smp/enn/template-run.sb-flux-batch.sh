#!/bin/bash
#FLUX: --job-name=smp-TARGET-cormorant
#FLUX: --queue=rondror
#FLUX: -t=86400
#FLUX: --priority=16

module load gcc/8.1.0
module load cuda/10.0
source /home/users/mvoegele/miniconda3/etc/profile.d/conda.sh
conda activate cormorant
echo $CUDA_HOME
LMDBDIR=/oak/stanford/groups/rondror/projects/atom3d/lmdb/SMP/splits/random/data/
python train.py --target TARGET --prefix smp-TARGET --load \
                --datadir $LMDBDIR --format lmdb --num-epoch 150
