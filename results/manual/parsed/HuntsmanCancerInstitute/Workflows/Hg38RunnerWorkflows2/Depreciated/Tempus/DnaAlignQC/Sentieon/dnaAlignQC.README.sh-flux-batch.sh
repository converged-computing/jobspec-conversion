#!/bin/bash
#FLUX: --job-name=chocolate-poo-7053
#FLUX: --queue=hci-rw
#FLUX: -t=345600
#FLUX: --urgency=16

set -e; start=$(date +'%s'); rm -f FAILED COMPLETE QUEUED; touch STARTED
echo -e "\n---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
module use /uufs/chpc.utah.edu/common/PE/proj_UCGD/modulefiles/$UUFSCELL &> /dev/null
module load sentieon/201911.00 &> /dev/null
module load snakemake/5.6.0 &> /dev/null
module load samtools/1.10 &> /dev/null
dataBundle=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/TNRunner
echo -n "-c 20" > sam2USeq.config.txt
name=${PWD##*/}
unset OMP_NUM_THREADS
allThreads=`nproc`
allRam=$(expr `free -g | grep -oP '\d+' | head -n 1` - 2)
shopt -s nullglob; fq=(*.gz)
fq1=`realpath ${fq[0]}`
fq2=`realpath ${fq[1]}`
echo
echo -n name"         : "; echo $name
echo -n threads"      : "; echo $allThreads
echo -n ram"          : "; echo $allRam
echo -n host"         : "; echo $(hostname)
echo -n fq1"          : "; echo $fq1
echo -n fq2"          : "; echo $fq2
echo -n s2u conf"     : "; cat sam2USeq.config.txt
echo; echo
ls $fq1 $fq2 sam2USeq.config.txt &> /dev/null
snakemake --printshellcmds --cores $allThreads --snakefile *.sm --config \
regionsForReadCoverage=$dataBundle/Bed/AllExonHg38Bed8April2020/hg38AllGeneExonsPad175bp.bed.gz \
regionsForOnTarget=$dataBundle/Bed/AllExonHg38Bed8April2020/hg38AllGeneExonsPad175bp.bed.gz \
indexFasta=$dataBundle/Indexes/B38IndexForBwa-0.7.17/hs38DH.fa \
dbsnp=$dataBundle/Vcfs/dbsnp_146.hg38.vcf.gz \
gSnp=$dataBundle/Vcfs/1000G_phase1.snps.high_confidence.hg38.vcf.gz \
gIndel=$dataBundle/Vcfs/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz \
useq=$dataBundle/BioApps/USeq/Apps \
ucsc=$dataBundle/BioApps/UCSC/ \
useqSamAlignmentExtractor="-q 20 -a 0.65 -d -f -u" \
useqSam2USeq="-v Hg38 -x 5000 -r -w sam2USeq.config.txt" \
name=$name \
fastqReadOne=$fq1 \
fastqReadTwo=$fq2 \
allThreads=$allThreads \
allRam=$allRam
mkdir -p RunScripts
mv dnaAlignQC* RunScripts/
mv sam2USeq.config.txt RunScripts/
rm -rf .snakemake 
rm -f FAILED STARTED DONE RESTART
touch COMPLETE 
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
mv -f slurm* Logs/ || true
	# /BioApps/Miniconda3/bin/snakemake --dag \
	# allRam=$allRam | dot -Tsvg > $name"_dag.svg"
