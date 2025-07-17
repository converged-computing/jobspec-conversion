#!/bin/bash
#FLUX: --job-name=blank-lizard-8112
#FLUX: -c=2
#FLUX: -t=172800
#FLUX: --urgency=16

export APPTAINER_CACHEDIR='$NOBACKUPDIR/apptainer_cachedir'
export APPTAINER_TMPDIR='$NOBACKUPDIR/apptainer_tmpdir'

set -euo pipefail
module purge 2> /dev/null
module load Apptainer/1.2.2 snakemake/7.32.3-gimkl-2022a-Python-3.11.3
NOBACKUPDIR="/nesi/nobackup/$SLURM_JOB_ACCOUNT/$USER"
export APPTAINER_CACHEDIR="$NOBACKUPDIR/apptainer_cachedir"
export APPTAINER_TMPDIR="$NOBACKUPDIR/apptainer_tmpdir"
mkdir -p "$APPTAINER_CACHEDIR" "$APPTAINER_TMPDIR"
setfacl -b "$APPTAINER_TMPDIR"  # avoid apptainer issues due to ACLs set on this folder
snakemake \
    --profile profiles/nesi \
    --workflow-profile profiles/nesi \
    --config account="$SLURM_JOB_ACCOUNT" \
    "$@"
