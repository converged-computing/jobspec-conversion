#!/bin/bash
#FLUX: --job-name=butterscotch-fudge-8166
#FLUX: -c=4
#FLUX: --priority=16

umask 002
SAMPLE=$1
LOCKFILE=samples/${SAMPLE}/process_sample.lock
lockfile -r 0 ${LOCKFILE} || exit 1
trap "rm -f ${LOCKFILE}; exit" SIGINT SIGTERM ERR EXIT
snakemake --reason \
    --rerun-incomplete \
    --keep-going \
    --printshellcmds \
    --config sample=${SAMPLE} \
    --nolock \
    --local-cores 4 \
    --jobs 500 \
    --max-jobs-per-second 1 \
    --use-conda \
    --use-singularity --singularity-args '--nv ' \
    --latency-wait 120 \
    --cluster-config workflow/process_sample.cluster.yaml \
    --cluster "sbatch --account={cluster.account} \
                      --partition={cluster.partition} \
                      --cpus-per-task={cluster.cpus} \
                      --output={cluster.out} {cluster.extra} " \
    --snakefile workflow/process_sample.smk
