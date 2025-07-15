#!/bin/bash
#FLUX: --job-name=cowy-peanut-1917
#FLUX: -c=4
#FLUX: --priority=16

umask 002
BATCH=$1
BIOSAMPLES=$2
CCSREADS=$3
TARGETS=$4
PROBES=${5:-None}
if [ -z $3 ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
 echo -e "\nUsage: sbatch $(basename $0) <batch_name> <biosample_csv> <hifi_reads> <target_bed> [<probe_bed>]\n"
 exit 0
fi
mkdir -p "batches/${BATCH}/"
LOCKFILE="batches/${BATCH}/process_batch.lock"
lockfile -r 0 "${LOCKFILE}" || exit 1
trap "rm -f ${LOCKFILE}; exit" SIGINT SIGTERM ERR EXIT
snakemake --reason \
    --rerun-incomplete \
    --keep-going \
    --printshellcmds \
    --configfile workflow/config.yaml \
    --config batch="${BATCH}" \
             biosamples="${BIOSAMPLES}" \
             ccsReads="${CCSREADS}" \
             targets="${TARGETS}" \
             probes="${PROBES}" \
             scripts=workflow/scripts \
    --nolock \
    --local-cores 4 \
    --jobs 750 \
    --max-jobs-per-second 1 \
    --use-conda --conda-frontend mamba \
    --use-singularity --singularity-args '--nv ' \
    --latency-wait 300 \
    --cluster-config workflow/cluster.yaml \
    --cluster "sbatch --partition={cluster.partition} \
                      --cpus-per-task={cluster.cpus} \
                      --output={cluster.out} {cluster.extra} " \
    --snakefile workflow/Snakefile
