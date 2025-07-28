#!/bin/bash
#FLUX: --job-name=crg2
#FLUX: -t=360000
#FLUX: --urgency=16

SF=~/crg2/Snakefile
CP="/hpf/largeprojects/ccm_dccforge/dccdipg/Common/snakemake"
SLURM=~/crg2/slurm_profile/
CONFIG=config_hpf.yaml
module purge
source /hpf/largeprojects/ccm_dccforge/dccdipg/Common/anaconda3/etc/profile.d/conda.sh
conda activate snakemake
snakemake --use-conda -s ${SF} --cores 4 --conda-prefix ${CP} --configfile ${CONFIG} --profile ${SLURM}
