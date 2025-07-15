#!/bin/bash
#FLUX: --job-name=delicious-diablo-3962
#FLUX: --priority=16

module load conda bioinfo-tools snakemake &&
snakemake -pr --jobs $SLURM_JOB_CPUS_PER_NODE\
    --use-envmodules\
    --use-conda\
    --conda-frontend conda\
    --shadow-prefix /scratch\
    all_hac
