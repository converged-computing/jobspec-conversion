#!/bin/bash
#FLUX: --job-name=smk-parent
#FLUX: --queue=long
#FLUX: --urgency=16

source ~/bin/snakemake/bin/activate
snakemake -s $1 --unlock
snakemake -s $1 --use-conda --printshellcmds --cluster 'sbatch -p {cluster.partition} --mem {cluster.mem} --out {cluster.out} --error {cluster.out} -c {cluster.cpu}' --cluster-config cluster.yml --jobs 100
