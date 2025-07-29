#!/bin/bash
#SBATCH --job-name=NF-hichip_alignment
#SBATCH --mail-user=thierya@crick.ac.uk
#SBATCH --mail-type=ALL,ARRAY_TASKS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-18:00:00

export TERM='xterm'
export NXF_VER='22.10.3'

export TERM=xterm
ml purge
ml Java/11.0.2
ml Nextflow/22.10.3
ml Singularity/3.6.4
export NXF_VER=22.10.3
nextflow pull nf-core/hic
nextflow run nf-core/hic \
    -r 2.0.0 \
    -c ./conf/crick_params.config \
    --digestion 'mboi' \
    --input  ./data/samplesheet.csv \
    --outdir ../output/NF-hichip_alignment \
    --email hamrude@crick.ac.uk \
    -resume
