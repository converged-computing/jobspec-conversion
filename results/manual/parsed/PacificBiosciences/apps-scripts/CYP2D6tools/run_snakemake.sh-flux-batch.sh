#!/bin/bash
#FLUX: --job-name=boopy-omelette-5665
#FLUX: -c=4
#FLUX: --priority=16

umask 002
BATCH=$1
BARCODES=$2
BIOSAMPLES=$3
HIFI=$4
if [ -z $3 ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
 echo -e "\nUsage: $(basename $0) <batch_name> <barcode_fasta> <biosample_csv> <hifi_reads.bam>\n"
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
    --configfile workflow/CYP2D6tools/config.yaml \
    --config batch="${BATCH}" \
             barcodeFa="${BARCODES}" \
             biosamples="${BIOSAMPLES}" \
             hifireads="${HIFI}" \
    --nolock \
    --local-cores 4 \
    --jobs 500 \
    --max-jobs-per-second 1 \
    --use-conda --conda-frontend mamba \
    --latency-wait 120 \
    --cluster-config workflow/CYP2D6tools/cluster.yaml \
    --cluster "sbatch --partition={cluster.partition} \
                      --cpus-per-task={cluster.cpus} \
                      --output={cluster.out} {cluster.extra} " \
    --snakefile workflow/CYP2D6tools/Snakefile
