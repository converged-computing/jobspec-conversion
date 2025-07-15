#!/bin/bash
#FLUX: --job-name=NF
#FLUX: -n=2
#FLUX: -c=10
#FLUX: -t=86400
#FLUX: --urgency=16

export PATH='$PATH:$PWD'
export http_proxy='proxy.saga:3128'
export https_proxy='proxy.saga:3128'

WORKDIR=$PWD
cd ${WORKDIR}
export PATH=$PATH:$PWD
echo "we are running from this directory: $SLURM_SUBMIT_DIR"
echo " the name of the job is: $SLURM_JOB_NAME"
echo "Th job ID is $SLURM_JOB_ID"
echo "The job was run on these nodes: $SLURM_JOB_NODELIST"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "We are using $SLURM_CPUS_ON_NODE cores"
echo "We are using $SLURM_CPUS_ON_NODE cores per node"
echo "Total of $SLURM_NTASKS cores"
export http_proxy=proxy.saga:3128
export https_proxy=proxy.saga:3128
module load Miniconda3/22.11.1-1
conda activate nf-core
nextflow  -v
nextflow main.nf --max_memory '160.GB' --max_cpus 20 -profile singularity --genome GRCh38 --input samples.csv --outdir rnaHG38sa
