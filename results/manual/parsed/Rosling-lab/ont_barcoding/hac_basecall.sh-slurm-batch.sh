#!/bin/bash
#FLUX: --job-name=ont_barcoding
#FLUX: --queue=node
#FLUX: -t=7200
#FLUX: --urgency=16

module load conda bioinfo-tools snakemake &&
snakemake -pr --jobs $SLURM_JOB_CPUS_PER_NODE\
    --use-envmodules\
    --use-conda\
    --conda-frontend conda\
    --shadow-prefix /scratch\
    all_hac
