#!/bin/bash
#SBATCH --account=hci-rw
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=hci-rw

set -e; start=$(date +'%s')
echo -e "\n---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
module load snakemake/6.4.1
jobDir=$(realpath .)
allThreads=$(nproc --all)
snakemake -p --cores all --config workingDir=$jobDir allThreads=$allThreads  --snakefile invitaeAutoProcessing.sm 
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
