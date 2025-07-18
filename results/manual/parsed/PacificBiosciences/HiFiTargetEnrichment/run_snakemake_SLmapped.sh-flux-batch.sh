#!/bin/bash
#FLUX: --job-name=boopy-cinnamonbun-3227
#FLUX: -c=4
#FLUX: --queue=compute
#FLUX: --urgency=16

umask 002
BATCH=$1
READS=$2
TARGETS=$3
PROBES=${4:-None}
if [ -z $3 ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
 echo -e "\nUsage: sbatch $(basename $0) <batch_name> <hifi_reads> <target_bed> [<probe_bed>]\n"
 echo -e "\n<hifi_reads> can be a directory of bams or a textfile with one bam path per line (fofn)\n"
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
             inputReads="${READS}" \
             targets="${TARGETS}" \
             probes="${PROBES}" \
             scripts=workflow/scripts \
    --nolock \
    --local-cores 4 \
    --jobs 500 \
    --max-jobs-per-second 1 \
    --use-conda --conda-frontend mamba \
    --use-singularity --singularity-args '--nv ' \
    --latency-wait 300 \
    --cluster-config workflow/cluster.yaml \
    --cluster "sbatch --partition={cluster.partition} \
                      --cpus-per-task={cluster.cpus} \
                      --output={cluster.out} {cluster.extra} " \
    --snakefile workflow/Snakefile_SLmapped
