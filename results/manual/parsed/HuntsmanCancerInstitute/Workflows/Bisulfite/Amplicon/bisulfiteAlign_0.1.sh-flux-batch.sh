#!/bin/bash
#FLUX: --job-name=bisulfiteAlign_0.1
#FLUX: --queue=hci-kp
#FLUX: -t=108000
#FLUX: --urgency=16

set -e; start=$(date +'%s')
echo -e "---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
jobName=`ls *_R1_*.fastq.gz | awk -F'_' '{print $1}'`
firstReadFastq=`ls *_R1_*.fastq.gz`
secondReadFastq=`ls *_R2_*.fastq.gz`
email=david.nix@hci.utah.edu
threads=`nproc`
memory=$(expr `free -g | grep -oP '\d+' | head -n 1` - 2)G
random=$RANDOM
echo "Threads: "$threads "  Memory: " $memory "  Host: " `hostname`; echo
snakemake --dag --snakefile *.sm  \
--config fR=$firstReadFastq sR=$secondReadFastq name=$jobName threads=$threads memory=$memory \
email=$email | dot -Tsvg > $jobName"_"$random"_dag.svg"
snakemake -p -T --cores $threads --snakefile *.sm  \
--config fR=$firstReadFastq sR=$secondReadFastq name=$jobName threads=$threads memory=$memory \
email=$email --stat $jobName"_"$random"_runStats.json"
mv -f *.json Log/
mv -f *.svg Log/
mv -f *.sh Log/
mv -f *.sm Log/
mv -f slurm* Log/
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
