#!/bin/bash
#SBATCH --job-name=BDSTP_crocs_CRBDP_hyperpriors
#SBATCH --output=BDSTP_crocs_CRBDP_hyperpriors.log
#SBATCH --error=BDSTP_crocs_CRBDP_hyperpriors.err
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32G
#SBATCH --time=12:00:00
#SBATCH --qos=low_prio_res

module load R
for ds in "Wilberg" "Stubbs";
do
    Rscript src/posteriors2gammaPriors.R empirical_analysis/output_CRBDP/CRBDP_ME_prior_0_${ds}.tre data/${ds}.priors.txt
done
echo "done ..."
