#!/bin/bash
#FLUX: --job-name=snakestar
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --urgency=16

scontrol show job $SLURM_JOB_ID
tflexPath="/mnt/cbib/thesis_gbm/tflex"
configpath="/mnt/cbib/thesis_gbm/mubriti_202303/scr1/config_mapping.yml"
module load snakemake
module load fastp
module load multiQC
module load STAR/2.7.10a # new Star
echo "running mapping "
snakemake -s $tflexPath/Snake_starmp.smk --cores 1 -j 12 \
    --configfile $configpath --latency-wait=30
