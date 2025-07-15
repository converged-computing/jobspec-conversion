#!/bin/bash
#FLUX: --job-name=phat-cupcake-4853
#FLUX: -c=4
#FLUX: --priority=16

COHORT=$1
umask 002
mkdir -p cohorts/${COHORT}/
LOCKFILE=cohorts/${COHORT}/process_cohort.lock
lockfile -r 0 ${LOCKFILE} || exit 1
trap "rm -f ${LOCKFILE}; exit" SIGINT SIGTERM ERR EXIT
source workflow/variables.env
snakemake \
    --config cohort=${COHORT} \
    --nolock \
    --profile workflow/profiles/slurm \
    --snakefile workflow/process_cohort.smk
