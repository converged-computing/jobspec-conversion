#!/bin/bash
#FLUX: --job-name=dirty-knife-2966
#FLUX: --urgency=16

module load conda bioinfo-tools snakemake &&
snakemake -pr --jobs $SLURM_JOB_CPUS_PER_NODE\
    --use-envmodules\
    --use-conda\
    --conda-frontend conda\
    --shadow-prefix /scratch
chmod -R g+rwX .snakemake/metadata &>/dev/null
