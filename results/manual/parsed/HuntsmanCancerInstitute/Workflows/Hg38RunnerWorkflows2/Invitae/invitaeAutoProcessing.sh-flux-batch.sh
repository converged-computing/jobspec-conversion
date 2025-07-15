#!/bin/bash
#FLUX: --job-name=psycho-sundae-3966
#FLUX: --queue=hci-rw
#FLUX: --urgency=16

set -e; start=$(date +'%s')
echo -e "\n---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
module load snakemake/6.4.1
jobDir=$(realpath .)
allThreads=$(nproc --all)
snakemake -p --cores all --config workingDir=$jobDir allThreads=$allThreads  --snakefile invitaeAutoProcessing.sm 
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
