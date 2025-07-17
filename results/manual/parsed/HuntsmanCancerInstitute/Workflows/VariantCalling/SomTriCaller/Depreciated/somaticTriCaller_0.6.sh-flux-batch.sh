#!/bin/bash
#FLUX: --job-name=crusty-fudge-4134
#FLUX: --queue=hci-kp
#FLUX: -t=864000
#FLUX: --urgency=16

set -e; start=$(date +'%s')
echo -e "---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
jobName=`basename $(pwd)`
tumorBam=0.01_0.bam
normalBam=norm_0.bam
regionsForAnalysis=/uufs/chpc.utah.edu/common/home/u0028003/Anno/B37/HunterKeith/b37_xgen_exome_targets_pad25.bed
mpileup=/uufs/chpc.utah.edu/common/home/u0028003/Lu/Underhill/BkgrdNormals/Exome/20BamXgenExome.mpileup.gz
minTumorAlignmentDepth=20
minNormalAlignmentDepth=20
minTumorAF=0.001
maxNormalAF=0.5
minTNRatio=1.2
minTNDiff=0.001
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
mv -f Filt/*_Consensus* .
rm -rf snappy* .snakemake
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
