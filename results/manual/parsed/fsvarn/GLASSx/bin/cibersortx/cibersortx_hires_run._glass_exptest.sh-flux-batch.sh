#!/bin/bash
#FLUX: --job-name=frigid-fork-4973
#FLUX: -c=12
#FLUX: -t=28800
#FLUX: --urgency=16

module load singularity
singularity exec \
-B /projects/verhaak-lab/GLASS-III/data/cibersortx/glass_exptest_20210212/:/src/data \
-B /projects/verhaak-lab/GLASS-III/results/cibersortx/hires/GLASS-exptest/:/src/outdir \
/projects/verhaak-lab/varnf/docker/CIBERSORTx/hires_latest.sif "/src/CIBERSORTxHiRes" \
--username Frederick.S.Varn.Jr.GR@dartmouth.edu \
--token  ef745da3ebf38e86c4b115ea37df2362 \
--mixture gene_tpm_matrix_all_samples.tsv \
--sigmatrix scgp_exp_sig.txt \
--label 'GLASS' \
--rmbatchSmode TRUE \
--refsample 10x_scgp_cibersortx_ref_02112021_TEST.txt \
--groundtruth klemm_purified_avg_ground_truth_cpm_tumor_subset.txt \
--subsetgenes common_genes.txt \
--threads 12 \
--cluster  true
