#!/bin/bash
#FLUX: --job-name=R_DXbootS
#FLUX: -c=8
#FLUX: -t=7200
#FLUX: --urgency=16

BASEDIR=${SLURM_SUBMIT_DIR}
function cleanup_ramdisk {
    echo -n "Cleaning up ramdisk directory /$SLURM_TMPDIR/ on "
    date
    rm -rf /$SLURM_TMPDIR
    echo -n "done at "
    date
}
trap "cleanup_ramdisk" TERM
module load R
mkdir -p /home/edickie/R/x86_64-pc-linux-gnu-library/4.1
Rscript ./code/R/running_bootedperm_DXeffects_SchaeferFC.R $SLURM_ARRAY_TASK_ID
