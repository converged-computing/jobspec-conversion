#!/bin/bash
#FLUX: --job-name=evasive-eagle-3838
#FLUX: -t=10800
#FLUX: --urgency=16

module load miniconda
source activate ovcexperiment
mkdir -p output_dir
python hotspots.py --seed=$SLURM_ARRAY_TASK_ID --n_batch=100 --batch_limit=8 --num_init=100 \
    --beta=1.0 --loss=elbo --dataset=civ --inner_samples=16 --outer_samples=16 \
    --use_tsvgp --output=output_dir/civ_ind_svgp_${SLURM_ARRAY_TASK_ID}_AMD_tsvgp.pt
