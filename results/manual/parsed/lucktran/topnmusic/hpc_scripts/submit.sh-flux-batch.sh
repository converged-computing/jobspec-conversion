#!/bin/bash
#FLUX: --job-name=ast_finetuned
#FLUX: --queue=dgxs
#FLUX: -t=7200
#FLUX: --urgency=16

module load python/3.12
module load cuda/12.2
source /nfs/hpc/share/dilgrenc/topnmusic/.venv/bin/activate
for lr in 5e-5
do
	for bs in 16
	do
   		.venv/bin/python3 ./src/topnmusic/ast_finetuned_audioset_finetuned_gtzan.py $lr $bs
    done
done
