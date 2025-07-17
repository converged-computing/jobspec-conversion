#!/bin/bash
#FLUX: --job-name=joyous-signal-2443
#FLUX: --queue=hci-rw
#FLUX: -t=172800
#FLUX: --urgency=16

set -e; start=$(date +'%s')
echo -e "\n---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
module load snakemake/6.4.1
jobDir=$(realpath .)
allThreads=$(nproc --all)
snakemake -p --cores all --config workingDir=$jobDir allThreads=$allThreads  --snakefile invitaeAutoProcessing.sm 
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
