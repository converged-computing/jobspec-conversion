#!/bin/bash
#FLUX: --job-name={SAMPLE}
#FLUX: -c=4
#FLUX: -t=36000
#FLUX: --urgency=16

module load python/anaconda-2022.05
source activate /home/jbard/beagle3-dadrummond/jbard/envs/py310_snake_star
cd {BASEDIR}
snakemake --snakefile {SNAKEFILE} --config sample={SAMPLE} \
fastq1="{FASTQ1}" \
STAR_index_dir={STAR} \
gtf={GTF} \
kallisto_index={KALLISTO} \
kallisto_direction="{KALLISTO_DIRECTION}" \
--cores all -p --use-conda
