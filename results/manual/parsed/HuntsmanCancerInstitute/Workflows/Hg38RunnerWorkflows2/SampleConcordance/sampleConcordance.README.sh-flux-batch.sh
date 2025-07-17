#!/bin/bash
#FLUX: --job-name=dirty-fork-3163
#FLUX: --queue=hci-rw
#FLUX: -t=172800
#FLUX: --urgency=16

set -e; start=$(date +'%s'); rm -f FAILED COMPLETE QUEUED STARTED
module load singularity
dataBundle=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/TNRunner
myData=/scratch/general/pe-nfs1/u0028003
container=$dataBundle/Containers/public_SM_BWA_1.sif
echo -e "\n---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
jobDir=`readlink -f .`
SINGULARITYENV_jobDir=$jobDir SINGULARITYENV_dataBundle=$dataBundle \
singularity exec --containall --bind $dataBundle,$myData $container \
bash $jobDir/*.sing
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
mkdir -p RunScripts
mv -f sampleConcordance*  RunScripts/
mv -f  *.yaml RunScripts/ &> /dev/null || true
cp slurm* Logs/ &> /dev/null || true
mv -f *snakemake.stats.json Logs/ &> /dev/null || true
rm -rf .snakemake STARTED RESTART* QUEUED slurm*
touch COMPLETE 
