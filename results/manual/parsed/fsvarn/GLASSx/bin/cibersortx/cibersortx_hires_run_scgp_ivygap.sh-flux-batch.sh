#!/bin/bash
#FLUX: --job-name=frigid-signal-1037
#FLUX: -c=12
#FLUX: -t=28800
#FLUX: --urgency=16

module load singularity
singularity exec \
-B /projects/verhaak-lab/GLASS-III/data/cibersortx/ivyGAP/:/src/data \
-B /projects/verhaak-lab/GLASS-III/results/cibersortx/hires/ivygap_scgp/:/src/outdir \
/projects/verhaak-lab/varnf/docker/CIBERSORTx/hires_latest.sif "/src/CIBERSORTxHiRes" \
--username Frederick.S.Varn.Jr.GR@dartmouth.edu \
--token  ef745da3ebf38e86c4b115ea37df2362 \
--mixture ivygap_fpkm_clean.txt \
--sigmatrix scgp_sig.txt \
--label 'ivygap' \
--rmbatchSmode TRUE \
--refsample 10x_scgp_cibersortx_ref_06092020.txt \
--groundtruth klemm_purified_avg_ground_truth_cpm_tumor_subset.txt \
--subsetgenes ivygap_common_genes.txt \
--threads 12 \
--cluster  true
