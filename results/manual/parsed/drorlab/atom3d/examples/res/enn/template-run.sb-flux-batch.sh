#!/bin/bash
#FLUX: --job-name=res-cormorant
#FLUX: --queue=rondror
#FLUX: -t=86400
#FLUX: --priority=16

module load gcc/8.1.0
module load cuda/10.0
source /home/users/mvoegele/miniconda3/etc/profile.d/conda.sh
conda activate cormorant
echo $CUDA_HOME
LMDBDIR=/oak/stanford/groups/rondror/projects/atom3d/lmdb/RES/splits/split-by-cath-topology/data
python train.py --prefix res --load \
                --datadir $LMDBDIR --format LMDB\
                --ddir-suffix "_split-by-cath-topology" \
                --maxnum MAXNUM \
		--samples SAMPLES \
		--batch-size 1 \
                --num-epoch 30
