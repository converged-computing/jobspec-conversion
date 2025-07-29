#!/bin/bash
#SBATCH --output=./slurm/logs/%x-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=80G
#SBATCH --time=16:00:00

module load gcc blast samtools bedtools bowtie2 python/3.10
virtualenv --no-download ${SLURM_TMPDIR}/env
source ${SLURM_TMPDIR}/env/bin/activate
pip install --no-index --upgrade pip
pip install --no-index metaphlan==4.0.3
pip install --no-index snakemake
pip install --no-index tabulate==0.8.10
snakemake -s snakefile_mockcomm_metaphlan.py --configfile configs/configfile.yaml --cores $SLURM_CPUS_PER_TASK --keep-going 
