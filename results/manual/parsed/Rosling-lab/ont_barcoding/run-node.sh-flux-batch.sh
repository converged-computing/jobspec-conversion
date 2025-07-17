#!/bin/bash
#FLUX: --job-name=ont_barcoding_2023
#FLUX: -n=4
#FLUX: --queue=core
#FLUX: -t=36000
#FLUX: --urgency=16

module load conda bioinfo-tools snakemake &&
snakemake -pr --jobs $SLURM_JOB_CPUS_PER_NODE\
    --use-envmodules\
    --use-conda\
    --conda-frontend conda\
    --shadow-prefix /scratch
chmod -R g+rwX .snakemake/metadata &>/dev/null
