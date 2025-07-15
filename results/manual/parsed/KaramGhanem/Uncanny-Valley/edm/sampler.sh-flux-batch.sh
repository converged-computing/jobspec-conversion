#!/bin/bash
#FLUX: --job-name=doopy-caramel-3717
#FLUX: -c=8
#FLUX: --queue=main
#FLUX: --urgency=16

module load miniconda/3 cuda/11.7
conda activate edm
python generate_sig_1.py
python generate_sig_2.py
python generate_sig_3.py
python generate_sig_4.py
cp $SLURM_TMPDIR  /network/scratch/k/karam.ghanem
