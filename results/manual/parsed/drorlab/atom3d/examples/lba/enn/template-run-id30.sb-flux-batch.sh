#!/bin/bash
#FLUX: --job-name=lba-id30-cutoff-CUTOFF-maxnumat-MAXNUM-cormorant
#FLUX: --queue=rondror
#FLUX: -t=86400
#FLUX: --urgency=16

module load gcc/8.1.0
module load cuda/10.0
source /home/users/mvoegele/miniconda3/etc/profile.d/conda.sh
conda activate cormorant
echo $CUDA_HOME
LMDBDIR=/oak/stanford/groups/rondror/projects/atom3d/lmdb/LBA/splits/split-by-sequence-identity-30/data
python train.py --target neglog_aff --prefix lba-id30_cutoff-CUTOFF_maxnumat-MAXNUM --load \
                --datadir $LMDBDIR --format lmdb \
		--cgprod-bounded \
                --radius CUTOFF \
                --maxnum MAXNUM \
                --batch-size 1 \
                --num-epoch 150 
