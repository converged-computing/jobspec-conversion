#!/bin/bash
#FLUX: --job-name=Unlock
#FLUX: -t=86400
#FLUX: --urgency=16

echo '########################################'
echo 'Date:' $(date --iso-8601=seconds)
echo 'User:' $USER
echo 'Host:' $HOSTNAME
echo 'Job Name:' $SLURM_JOB_NAME
echo 'Job Id:' $SLURM_JOB_ID
echo 'Directory:' $(pwd)
echo '########################################'
module load snakemake/5.19.2
rm -fr config_ongoing_run.yaml
cp configs/config_main.yaml config_ongoing_run.yaml
snakemake --unlock --drmaa --cores 1 -s workflow/quality_control.rules
rm config_ongoing_run.yaml
mkdir -p slurm_output
mv Unlock-* slurm_output
echo "Working directory unlocked"
