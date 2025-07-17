#!/bin/bash
#FLUX: --job-name=gloopy-plant-4223
#FLUX: --queue=hci-rw
#FLUX: -t=345600
#FLUX: --urgency=16

module load singularity
dataBundle=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/atlatl
container=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/TNRunner/Containers/public_STAR_SM_1.sif
set -e
rm -f FAILED COMPLETE QUEUED; touch STARTED
start=$(date +'%s')
jobDir=$(realpath .)
name=${PWD##*/}
tempDir=/scratch/local/$USER/$SLURM_JOB_ID
rm -rf $tempDir &> /dev/null || true; mkdir -p $tempDir/$name || true
echo -e "\n---------- Copying job files to tempDir -------- $((($(date +'%s') - $start)/60)) min"
rsync -rtL --exclude 'slurm-*' $jobDir/ $tempDir/$name/ && echo CopyOverOK || echo CopyOverFAILED
echo -e "\n---------- Launching container -------- $((($(date +'%s') - $start)/60)) min"
cd $tempDir/$name
set +e
SINGULARITYENV_jobDir=$tempDir/$name SINGULARITYENV_dataBundle=$dataBundle \
  singularity exec --containall --bind $dataBundle,$tempDir/$name $container \
  bash $tempDir/$name/*.sing
echo -e "\n---------- Files In Temp -------- $((($(date +'%s') - $start)/60)) min"
ls -1 $tempDir/$name
echo -e "\n---------- Copying back results -------- $((($(date +'%s') - $start)/60)) min"
sleep 2s
rm -rf $tempDir/$name/*.cram $tempDir/$name/*.crai &> /dev/null || true
rsync -rtL --exclude '*q.gz' $tempDir/$name/ $jobDir/ && echo CopyBackOK || { echo CopyBackFAILED; rm -f COMPLETE; }
echo -e "\n---------- Files In JobDir -------- $((($(date +'%s') - $start)/60)) min"
ls -1 $jobDir; cd $jobDir; rm -rf $tempDir &> /dev/null || true
if [ -f COMPLETE ];
then
  echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
  mkdir -p RunScripts
  mv -f slurm* *stats.json Logs/ 
  mv -f rnaAlignQC* RUNME *yaml RunScripts/ 
  rm -rf .snakemake STARTED RESTARTED QUEUED FAILED *cram* *q.gz
else
  echo -e "\n---------- FAILED! -------- $((($(date +'%s') - $start)/60)) min total"
  rm -rf STARTED RESTARTED QUEUED
  touch FAILED
fi
