#!/bin/bash
#FLUX: --job-name=loopy-citrus-8857
#FLUX: -c=4
#FLUX: --priority=16

COHORT=$1
umask 002
COHORTDIR="cohorts/${COHORT}"
LOCKFILE="$COHORTDIR/process_cohort.lock"
if [ -f "$LOCKFILE" ]; then
    echo "lockfile $LOCKFILE already exists. Remove lockfile and try again." && exit 1
else
    mkdir -p "$COHORTDIR" || exit 1
    touch "$LOCKFILE" || exit 1
fi
trap 'rm -f ${LOCKFILE}; exit' SIGINT SIGTERM ERR EXIT
source workflow/variables.env
snakemake \
    --config "cohort='$COHORT'" \
    --nolock \
    --profile workflow/profiles/slurm \
    --snakefile workflow/process_cohort.smk
