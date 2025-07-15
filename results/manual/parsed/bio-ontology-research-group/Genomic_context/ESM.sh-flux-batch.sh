#!/bin/bash
#FLUX: --job-name=tart-caramel-7328
#FLUX: -c=4
#FLUX: --queue=batch
#FLUX: -t=7200
#FLUX: --priority=16

echo $OMP_NUM_THREADS
source activate base
module load cuda/11.7.1
cd /home/toibazd/Data/BERT/
python  ESM/extract.py esm2_t36_3B_UR50D ESM/few_proteins.fasta ESM/some_proteins_emb_esm2 --repr_layers 36 --include mean
