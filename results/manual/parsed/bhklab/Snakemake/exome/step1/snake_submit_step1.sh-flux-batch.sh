#!/bin/bash
#FLUX: --job-name=snake_step1
#FLUX: -t=259200
#FLUX: --urgency=16

source /cluster/home/amammoli/.bashrc
module load python3
output_dir="/cluster/home/amammoli/exome" snakemake -s /path/to/gitclone/step1/Snakefile_step1 --latency-wait 100 -j 100 --cluster 'sbatch -t {params.runtime} --mem={resources.mem_mb} -c {threads}'
