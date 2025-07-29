#!/bin/bash
#SBATCH --job-name=easel
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --partition=general
#SBATCH --qos=general

module load nextflow
source activate envAGAT
nextflow run main.nf -w karl -with-report -with-timeline -with-dag acer_nf.png \
--species acer_negundo \
--genome /core/labs/Wegrzyn/easel-workshop/data/genome/chr1.fna \
--outdir . \
--sra /core/labs/Wegrzyn/easel-workshop/data/sra/acer_negundo.txt
