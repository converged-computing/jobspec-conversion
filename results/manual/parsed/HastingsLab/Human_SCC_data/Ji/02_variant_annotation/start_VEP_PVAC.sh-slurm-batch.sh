#!/bin/bash
#SBATCH --job-name=Merge
#SBATCH --mail-user=eknodel@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40000
#SBATCH --time=10:00:00

source activate vep_env
module load bcftools-1.14-gcc-11.2.0
snakemake --snakefile VEP_PVACseq.snakefile -j 71 --keep-target-files --rerun-incomplete --cluster "sbatch -q public -p general -n 1 -c 1 --mem=50000 -t 0-10:00:00"
