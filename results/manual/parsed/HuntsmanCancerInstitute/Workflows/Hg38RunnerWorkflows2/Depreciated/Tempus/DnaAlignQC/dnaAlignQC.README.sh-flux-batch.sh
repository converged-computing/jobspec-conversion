#!/bin/bash
#FLUX: --job-name=fugly-eagle-8107
#FLUX: --queue=hci-rw
#FLUX: -t=345600
#FLUX: --urgency=16

set -e; start=$(date +'%s'); rm -f FAILED COMPLETE QUEUED; touch STARTED
module load singularity/3.6.4
tempDir=/scratch/local/TempDeleteMe_u0028003
dataBundle=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/TNRunner
regionsForReadCoverage=$dataBundle/Bed/Tempus/TempusXT648Hg38/refGeneTempusXT648_CCDS.bed.gz
regionsForOnTarget=$dataBundle/Bed/AllExonHg38Bed8April2020/hg38AllGeneExonsPad175bp.bed.gz
container=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/Nix/SingularityBuilds/public_SnakeMakeBioApps_5.sif
echo -e "\n---------- Copying Resources to Temp Dir -------- $((($(date +'%s') - $start)/60)) min"
name=${PWD##*/}
jobDir=`readlink -f .`
echo "Checking for required files"
ls 1.fastq.gz 2.fastq.gz sam2USeq.config.txt dnaAlignQC.README.sh dnaAlignQC.sing dnaAlignQC.sm > /dev/null
echo
rm -rf $tempDir
mkdir -p $tempDir/$name $tempDir/Ref
echo "fastqOne     : "$(realpath 1.fastq.gz)
echo "fastqTwo     : "$(realpath 2.fastq.gz)
rsync -rtL --exclude 'slurm-*' $jobDir/ $tempDir/$name/
indexFastaTruncated=$dataBundle/Indexes/B38IndexForBwa-0.7.17/hs38DH
dbsnp=$dataBundle/Vcfs/dbsnp_146.hg38.vcf.gz
gSnp=$dataBundle/Vcfs/1000G_phase1.snps.high_confidence.hg38.vcf.gz
gIndel=$dataBundle/Vcfs/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz
rsync -rtL $regionsForReadCoverage* $regionsForOnTarget* $indexFastaTruncated* $dbsnp* $gSnp* $gIndel* $tempDir/Ref/
set +e
echo -e "\n---------- Launching Workflow -------- $((($(date +'%s') - $start)/60)) min"
SINGULARITYENV_name=$name \
SINGULARITYENV_tempDir=$tempDir \
SINGULARITYENV_regionsForReadCoverage=${regionsForReadCoverage##*/} \
SINGULARITYENV_regionsForOnTarget=${regionsForOnTarget##*/} \
SINGULARITYENV_regionsForReadCoverage=${regionsForReadCoverage##*/} \
SINGULARITYENV_indexFastaTruncated=${indexFastaTruncated##*/} \
SINGULARITYENV_dbsnp=${dbsnp##*/} \
SINGULARITYENV_gSnp=${gSnp##*/} \
SINGULARITYENV_gIndel=${gIndel##*/} \
singularity exec --containall --bind $tempDir $container \
bash $tempDir/$name/*.sing && touch COMPLETE
echo -e "\n---------- Copying back results -------- $((($(date +'%s') - $start)/60)) min"
rsync -rtL --exclude '*.fastq.gz' $tempDir/$name/ $jobDir/
rm -rf $tempDir
if [ -f COMPLETE ];
then
  mkdir -p RunScripts
  mv dnaAlignQC* sam2USeq.config.txt RunScripts/
  mv -f *.log  Logs/ || true
  rm -rf .snakemake
  rm -f FAILED STARTED DONE RESTART QUEUED
  echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
  mv -f slurm* Logs/ || true
else
  echo -e "\n---------- FAILED! -------- $((($(date +'%s') - $start)/60)) min total"
  touch FAILED
  rm -f STARTED DONE RESTART QUEUED
fi
