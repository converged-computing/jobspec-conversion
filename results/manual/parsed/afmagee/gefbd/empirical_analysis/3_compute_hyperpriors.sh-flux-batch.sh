#!/bin/bash
#FLUX: --job-name=BDSTP_crocs_CRBDP_hyperpriors
#FLUX: -n=2
#FLUX: -t=43200
#FLUX: --priority=16

module load R
for ds in "Wilberg" "Stubbs";
do
    Rscript src/posteriors2gammaPriors.R empirical_analysis/output_CRBDP/CRBDP_ME_prior_0_${ds}.tre data/${ds}.priors.txt
done
echo "done ..."
