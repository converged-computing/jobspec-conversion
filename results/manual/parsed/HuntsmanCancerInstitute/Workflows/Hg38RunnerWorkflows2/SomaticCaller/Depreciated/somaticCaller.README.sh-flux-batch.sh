#!/bin/bash
#FLUX: --job-name=eccentric-bicycle-7784
#FLUX: --queue=hci-rw
#FLUX: --priority=16

set -e; start=$(date +'%s'); rm -f FAILED COMPLETE QUEUED; touch STARTED
module load singularity
dataBundle=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/TNRunner
container=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/TNRunner/Containers/public_ILLUM_SM_1.sif
echo -e "\n---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
jobDir=`readlink -f .`
SINGULARITYENV_jobDir=$jobDir SINGULARITYENV_dataBundle=$dataBundle \
singularity exec --containall --bind $dataBundle $container \
bash $jobDir/*.sing
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
mkdir -p RunScripts
mv -f somaticCaller*  RunScripts/
mv -f  *.yaml RunScripts/ &> /dev/null || true
cp slurm* Logs/ &> /dev/null || true
mv -f *snakemake.stats.json Logs/ &> /dev/null || true
rm -rf .snakemake STARTED RESTART* QUEUED slurm*
touch COMPLETE 
