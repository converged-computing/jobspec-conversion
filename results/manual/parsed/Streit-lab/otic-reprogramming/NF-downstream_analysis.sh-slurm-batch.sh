#!/bin/bash
#SBATCH --job-name=NF-downstream_analysis
#SBATCH --mail-user=alex.thiery@crick.ac.uk
#SBATCH --mail-type=ALL,ARRAY_TASKS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00

export TERM='xterm'
export NXF_VER='20.07.1'
export NXF_SINGULARITY_CACHEDIR='/camp/home/thierya/working/NF_singularity'

ml purge
ml Nextflow/20.07.1
ml Singularity/3.4.2
ml Graphviz
export TERM=xterm
export NXF_VER=20.07.1
export NXF_SINGULARITY_CACHEDIR=/camp/home/thierya/working/NF_singularity
nextflow run ./NF-downstream_analysis/main.nf \
  -c ./configs/crick.config \
  --input ./NF-downstream_analysis/crick_samplesheet.csv \
  --outdir output/NF-downstream_analysis \
  -resume
