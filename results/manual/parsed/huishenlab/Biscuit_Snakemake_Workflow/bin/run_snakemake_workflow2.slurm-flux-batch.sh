#!/bin/bash
#FLUX: --job-name=SNAKEMASTER
#FLUX: --queue=long
#FLUX: -t=864000
#FLUX: --urgency=16

mkdir -p logs/workflows
cd $SLURM_SUBMIT_DIR
snakemake_module="bbc2/snakemake/snakemake-7.25.0"
module load $snakemake_module
logs_dir="logs/"
[[ -d $logs_dir ]] || mkdir -p $logs_dir
echo "Start snakemake workflow." >&1                   
echo "Start snakemake workflow." >&2     
snakemake \
-p \
--latency-wait 20 \
--use-conda \
--jobs 100 \
--cluster "mkdir -p logs/{rule}; sbatch \
-p short,long,laird \
--export=ALL \
--ntasks {threads} \
--mem={resources.mem_gb}G \
-t {resources.time}"
echo "snakemake workflow done." >&1                   
echo "snakemake workflow done." >&2                
