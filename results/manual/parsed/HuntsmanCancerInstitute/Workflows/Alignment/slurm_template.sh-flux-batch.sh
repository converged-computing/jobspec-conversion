#!/bin/bash
#FLUX: --job-name=MYNAME
#FLUX: --queue=hci-rw
#FLUX: -t=108000
#FLUX: --urgency=16

jobName=MYNAME
coreID=MYID
readCoverageBed=panel_merged.bed
onTargetBed=panel_merged_ext25.bed
smfile=alignQC_1.4.sm 
echo "---------- Starting job $jobName -------- "
echo -e "Start: $((($(date +'%s') - $start)/60)) min"
module use /uufs/chpc.utah.edu/common/home/hcibcore/Modules/modulefiles
module use /uufs/chpc.utah.edu/common/HIPAA/hci-bioinformatics1/Modules/modulefiles
module load snakemake
snakemake=`which snakemake`
firstReadFastq=`ls *_1.txt.gz`
secondReadFastq=`ls *_2.txt.gz`
memory=$(expr `free -g | grep -oP '\d+' | head -n 1` - 8)G
start=$(date +'%s')
echo "Fastq files: $firstReadFastq $secondReadFastq"
echo "Bed files: $readCoverageBed $onTargetBed"
$snakemake \
--dag --latency-wait 15 --snakefile $smfile \
--config fR=$firstReadFastq sR=$secondReadFastq \
rcBed=$readCoverageBed otBed=$onTargetBed \
name=$jobName id=$coreID threads=$NCPU memory=$memory \
| dot -Tsvg > ${jobName}_dag.svg
$snakemake \
-p -T --latency-wait 15 --cores $NCPU --snakefile $smfile \
--config fR=$firstReadFastq sR=$secondReadFastq \
rcBed=$readCoverageBed otBed=$onTargetBed \
name=$jobName id=$coreID threads=$NCPU memory=$memory 
echo "\n---------- Complete! -------- "
echo -e "$((($(date +'%s') - $start)/60)) min total"
