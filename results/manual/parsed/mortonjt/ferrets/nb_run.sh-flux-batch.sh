#!/bin/bash
#FLUX: --job-name=chocolate-car-0071
#FLUX: --queue=ccb
#FLUX: -t=432000
#FLUX: --urgency=16

source ~/.bashrc
conda activate stan
cd /mnt/home/jmorton/research/ferrets
microbe=$SLURM_ARRAY_TASK_ID
python scripts/single_nb_fit.py \
    --biom data/File_1_TaoDing_microbiome.biom \
    --metadata data/File_3_FerretMicrobiomeMetadata.xlxs.xlsx \
    --batch results/batch_results.pickle \
    --microbe $microbe \
    --model models/nb-single-regression.stan \
    --output-file results/stan_params/posterior_${microbe}.pickle
