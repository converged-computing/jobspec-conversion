#!/bin/bash
#SBATCH --job-name=10x-NPB
#SBATCH --mail-user=alex.thiery@crick.ac.uk
#SBATCH --mail-type=ALL,ARRAY_TASKS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00

export TERM='xterm'
export NXF_VER='20.07.1'

export TERM=xterm
ml purge
ml Nextflow/20.07.1
ml Singularity/3.4.2
ml Graphviz
export NXF_VER=20.07.1
nextflow run ./NF-downstream_analysis/workflows/seurat/main.nf \
--input ./NF-downstream_analysis/samplesheet.csv \
--outdir ./output/NF-downstream_analysis \
-profile crick
