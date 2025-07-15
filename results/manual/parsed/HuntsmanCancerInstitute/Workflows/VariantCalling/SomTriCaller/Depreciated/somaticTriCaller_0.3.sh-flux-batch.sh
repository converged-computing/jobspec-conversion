#!/bin/bash
#FLUX: --job-name=hanky-house-5085
#FLUX: --queue=hci-kp
#FLUX: --priority=16

set -e; start=$(date +'%s')
echo -e "---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
jobName=T_N_1Thread
tumorBam=T_final.bam
normalBam=N_final.bam
regionsForAnalysis=/uufs/chpc.utah.edu/common/home/u0028003/Anno/B37/HunterKeith/HSV1_GBM_IDT_Probes_B37Pad25bps.bed
mpileup=/uufs/chpc.utah.edu/common/home/u0028003/Lu/Underhill/BkgrdNormals/HSV1_GBM_IDT.mpileup.gz
minTumorAlignmentDepth=100
minNormalAlignmentDepth=50 
minTumorAF=0.01
maxNormalAF=0.01
minTNRatio=2
minTNDiff=0.01
minZScore=4
email=david.nix@hci.utah.edu
threads=`nproc`
memory=$(expr `free -g | grep -oP '\d+' | head -n 1` - 2)G
echo "Threads: "$threads "  Memory: " $memory "  Host: " `hostname`; echo
~/BioApps/SnakeMake/snakemake  --dag --snakefile *.sm  \
--config name=$jobName rA=$regionsForAnalysis tBam=$tumorBam nBam=$normalBam  threads=$threads memory=$memory \
email=$email mpileup=$mpileup mtad=$minTumorAlignmentDepth mnad=$minNormalAlignmentDepth mtaf=$minTumorAF \
mnaf=$maxNormalAF mr=$minTNRatio md=$minTNDiff zscore=$minZScore \
| dot -Tsvg > $jobName"_dag.svg"
~/BioApps/SnakeMake/snakemake -p -T --cores $threads --snakefile *.sm \
--config name=$jobName rA=$regionsForAnalysis tBam=$tumorBam nBam=$normalBam  threads=$threads memory=$memory \
email=$email mpileup=$mpileup mtad=$minTumorAlignmentDepth mnad=$minNormalAlignmentDepth mtaf=$minTumorAF \
mnaf=$maxNormalAF mr=$minTNRatio md=$minTNDiff zscore=$minZScore
mkdir -p Raw Txt Filt Log;
gzip *.log
mv -f *.log.gz Log/
mv -f *.raw.* Raw/
mv -f *.txt.gz Txt/
mv -f *.filt.* Filt/
rm -f snappy*
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
