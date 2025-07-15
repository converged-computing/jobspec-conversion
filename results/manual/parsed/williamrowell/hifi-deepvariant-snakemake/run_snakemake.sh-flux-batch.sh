#!/bin/bash
#FLUX: --job-name=scruptious-butter-2442
#FLUX: -c=4
#FLUX: --urgency=16

umask 002
SAMPLE=$1
mkdir -p "samples/${SAMPLE}/"
LOCKFILE="samples/${SAMPLE}/process_sample.lock"
lockfile -r 0 "${LOCKFILE}" || exit 1
trap "rm -f ${LOCKFILE}; exit" SIGINT SIGTERM ERR EXIT
snakemake --reason \
    --rerun-incomplete \
    --keep-going \
    --printshellcmds \
    --config sample="${SAMPLE}" \
    --nolock \
    --local-cores 4 \
    --jobs 500 \
    --max-jobs-per-second 1 \
    --use-conda --conda-frontend mamba \
    --use-singularity --singularity-args '--nv ' \
    --latency-wait 120 \
    --cluster-config workflow/cluster.yaml \
    --cluster "sbatch --partition={cluster.partition} \
                      --cpus-per-task={cluster.cpus} \
                      --output={cluster.out} {cluster.extra} " \
    --snakefile workflow/Snakefile
