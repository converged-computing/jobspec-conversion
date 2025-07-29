#!/bin/bash
#SBATCH --job-name=k562_chip
#SBATCH --output=nextflow.out
#SBATCH --error=nextflow.err
#SBATCH --mail-user=john.rinn@colorado.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6gb
#SBATCH --time=4-04:00:00

pwd; hostname; date
echo "Booyakasha, Big up Yaself -- you've requested $SLURM_CPUS_ON_NODE core."
module load singularity/3.1.1
nextflow run nf-core/chipseq -r 1.1.0 \
-profile singularity \
--input DESIGN_BIGlebowski_fixed.csv \
--fasta /Shares/rinn_class/data/genomes/human/gencode/v32/GRCh38.p13.genome.fa \
--gtf /Shares/rinn_class/data/genomes/human/gencode/v32/gencode.v32.annotation.gtf \
--macs_gsize 2.7e9 \
--blacklist hg38-blacklist.v2.bed \
--email john.rinn@colorado.edu \
-resume \
-c nextflow.config
date
