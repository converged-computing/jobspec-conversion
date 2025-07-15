#!/bin/bash
#FLUX: --job-name=mat2csv
#FLUX: -c=8
#FLUX: -t=15600
#FLUX: --priority=16

module purge
source /cluster/projects/p33/users/mohammadzr/envs/pynext38/bin/activate
python ../mostest_code/pvals2csv_touse.py --mat ../../lipids/europeans/mostest/nmr_eur_${SLURM_ARRAY_TASK_ID}.mat --bim ../../lipids/europeans/zscores/glm_original_combined_zscore.csv_bim_as_ref.csv --n ../../lipids/europeans/zscores/n_max_nmr249_eur.csv --out ../lipids/europeans/mostest/nmr_eur_${SLURM_ARRAY_TASK_ID}.mat.csv
echo 'Done'
