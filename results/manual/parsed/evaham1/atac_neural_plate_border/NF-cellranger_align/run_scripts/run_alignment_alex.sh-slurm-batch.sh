#!/bin/bash
#SBATCH --job-name=NF-cellranger_atac_align
#SBATCH --mail-user=hamrude@crick.ac.uk
#SBATCH --mail-type=ALL,ARRAY_TASKS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00

export TERM='xterm'
export NXF_VER='21.10.6'

export TERM=xterm
ml purge
ml Nextflow/21.10.6
ml Singularity/3.4.2
ml Graphviz
export NXF_VER=21.10.6
nextflow pull Streit-lab/cellranger_multiomic
nextflow run Streit-lab/cellranger_multiomic \
    -r main \
    -c ./conf/crick_params_alex.config \
    --sample_sheet ./samplesheet_alex.csv \
    --outdir ../output/NF-cellranger_align \
    --email thierya@crick.ac.uk \
    -resume
