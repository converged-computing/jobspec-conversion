#!/bin/bash
#SBATCH --account=100humans
#SBATCH --output=cluster_logs/slurm-%x-%j-%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4

SAMPLE=$1
umask 002
SAMPLEDIR="cohorts/${SAMPLE}"
LOCKFILE="$SAMPLEDIR/process_cohort.lock"
if [ -f "$LOCKFILE" ]; then
    echo "lockfile $LOCKFILE already exists. Remove lockfile and try again." && exit 1
else
    mkdir -p "$SAMPLEDIR" || exit 1
    touch "$LOCKFILE" || exit 1
fi
trap 'rm -f ${LOCKFILE}; exit' SIGINT SIGTERM ERR EXIT
source workflow/variables.env
snakemake \
    --config "sample='$SAMPLE'" \
    --nolock \
    --profile workflow/profiles/slurm \
    --snakefile workflow/process_sample.smk
