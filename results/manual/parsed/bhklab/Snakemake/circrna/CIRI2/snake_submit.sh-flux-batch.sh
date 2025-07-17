#!/bin/bash
#FLUX: --job-name=snake_ciri_gdsc
#FLUX: -t=259200
#FLUX: --urgency=16

source /cluster/home/amammoli/.bashrc
module load python3
output_dir="/cluster/projects/bhklab/Data/ncRNA_detect/circRNA/CIRI2/GDSC"  snakemake -s /cluster/projects/bhklab/Data/ncRNA_detect/circRNA/CIRI2/GDSC/Snakefile --latency-wait 150 -j 300 --cluster 'sbatch -t {params.runtime} --mem={resources.mem_mb} -c {threads} -p {params.partition}'
