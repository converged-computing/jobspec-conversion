#!/bin/bash
#SBATCH --job-name=NF
#SBATCH --account=nn9036k
#SBATCH --output=nfSLURMLOG
#SBATCH --mail-user=animesh.sharma@ntnu.no
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1-00:00:00

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
