#!/bin/bash
#SBATCH --job-name=nanome.google_demo
#SBATCH --output=log/%x.%j.log
#SBATCH --mail-user=yang.liu@jax.org
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=6G
#SBATCH --time=3-00:00:00
#SBATCH --partition=batch

set -e
baseDir=${1:-/fastscratch/$USER/nanome}
gcpProjectName=${2:-"jax-nanopore-01"}
WORK_DIR_BUCKET=${3:-"gs://jax-nanopore-01-project-data/NANOME-TestData-work"}
OUTPUT_DIR_BUCKET=${4:-"gs://jax-nanopore-01-export-bucket/NANOME-TestData-ouputs"}
pipelineName="gcp_nanome_demo"
rm -rf $baseDir/$pipelineName
mkdir -p $baseDir/$pipelineName
cd $baseDir/$pipelineName
set -ex
date;hostname;pwd
set +x
source $(conda info --base)/etc/profile.d/conda.sh
conda activate py39
gsutil -m rm -rf ${WORK_DIR_BUCKET}  ${OUTPUT_DIR_BUCKET} >/dev/null 2>&1 || true
set -x
echo "### NANOME pipeline for demo data on google START"
nextflow run ${NANOME_DIR}\
    -profile docker,google \
	-w ${WORK_DIR_BUCKET} \
	--outdir ${OUTPUT_DIR_BUCKET} \
	--googleProjectName ${gcpProjectName}\
	--dsname TestData \
	--input https://storage.googleapis.com/jax-nanopore-01-project-data/nanome-input/demo1_fast5_reads.tar.gz
echo "### NANOME pipeline for demo data on google DONE"
