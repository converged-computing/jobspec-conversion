#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: --queue=cpu
#FLUX: -t=259200
#FLUX: --urgency=16

source ~/.bashrc
conda activate snakemake
snakemake -n --latency-wait 100 --rerun-incomplete -p \
--cluster "sbatch --ntasks 1 --cpus-per-task {threads} --partition cpu --job-name {rule} --time 5:00:00 -e logs/{rule}/{params.err} -o logs/{rule}/{params.out} --mem {resources.mem_mb} --parsable" \
--jobs 500 --keep-going --use-envmodules --cluster-status ./status-sacct.sh
