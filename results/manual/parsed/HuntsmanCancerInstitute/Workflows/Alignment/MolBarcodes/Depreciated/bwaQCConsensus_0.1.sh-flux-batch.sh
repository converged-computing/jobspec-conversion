#!/bin/bash
#FLUX: --job-name=bwaCon
#FLUX: --queue=hci-kp
#FLUX: --urgency=16

set -e; start=$(date +'%s')
echo -e "---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
jobName=`ls *_R1.fastq.gz | awk -F'_R1.fastq.gz' '{print $1}'`
firstReadFastq=`ls *_R1.fastq.gz`
secondReadFastq=`ls *_R3.fastq.gz`
barcodeReadFastq=`ls *_R2.fastq.gz`
email=david.nix@hci.utah.edu
readCoverageBed=/uufs/chpc.utah.edu/common/home/u0028003/Lu/KeithTNExomes/Bed/b37_xgen_exome_targets.bed.gz
onTargetBed=/uufs/chpc.utah.edu/common/home/u0028003/Lu/KeithTNExomes/Bed/b37_xgen_exome_probes_pad25.bed.gz
analysisBed=/uufs/chpc.utah.edu/common/home/u0028003/Lu/KeithTNExomes/Bed/b37_xgen_exome_targets_pad25.bed.gz
threads=`nproc`
memory=$(expr `free -g | grep -oP '\d+' | head -n 1` - 2)G
random=$RANDOM
echo "Threads: "$threads "  Memory: " $memory "  Host: " `hostname`; echo
snakemake -p -T --cores $threads --snakefile bwaQCConsensus_0.1.sm  \
--config fR=$firstReadFastq sR=$secondReadFastq bR=$barcodeReadFastq \
rCB=$readCoverageBed oTB=$onTargetBed aB=$analysisBed \
name=$jobName threads=$threads memory=$memory email=$email 
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
