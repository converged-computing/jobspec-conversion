#!/bin/bash
#FLUX: --job-name=stinky-plant-6438
#FLUX: -c=4
#FLUX: --urgency=16

umask 002
BATCH=$1
BIOSAMPLES=$2
HIFI=$3
if [ -z $3 ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
 echo -e "\nUsage: $(basename $0) <batch_name> <biosample_csv> <hifi_reads.bam>\n"
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
             hifiReads="${HIFI}" \
    --nolock \
    --local-cores 16 \
    --jobs 500 \
    --max-jobs-per-second 1 \
    --use-conda --conda-frontend mamba \
    --latency-wait 120 \
    --cluster-config workflow/cluster.yaml \
    --snakefile workflow/Snakefile \
    --cluster "sbatch --partition={cluster.partition} \
                      --cpus-per-task={cluster.cpus} \
                      --output={cluster.out} {cluster.extra} " \
