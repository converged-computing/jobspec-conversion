#!/bin/bash
#SBATCH --job-name=NF-lmx1a
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
nextflow pull nf-core/rnaseq
nextflow run nf-core/rnaseq \
  -r 2.0 \
  -c ./configs/crick.config \
  --aligner star \
  --input ./NF-lmx1a_alignment/crick_samplesheet.csv \
  --outdir output/NF-lmx1a_alignment \
  --email alex.thiery@crick.ac.uk \
  -resume
