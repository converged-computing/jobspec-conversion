#!/bin/bash
#FLUX: --job-name=confused-parrot-9606
#FLUX: --queue=hci-rw
#FLUX: -t=172800
#FLUX: --urgency=16

set -e; start=$(date +'%s'); rm -f FAILED COMPLETE QUEUED; touch STARTED
module load singularity
dataBundle=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/TNRunner
container=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/TNRunner/Containers/public_Gatk_Latest_Sm_1.sif
echo -e "\n---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
jobDir=`readlink -f .`
SINGULARITYENV_jobDir=$jobDir SINGULARITYENV_dataBundle=$dataBundle \
singularity exec --containall --bind $dataBundle $container \
bash $jobDir/*.sing
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
mkdir -p RunScripts
mv -f mutect*  RunScripts/
mv -f  *.yaml RunScripts/ &> /dev/null || true
cp slurm* Logs/ &> /dev/null || true
mv -f *snakemake.stats.json Logs/ &> /dev/null || true
rm -rf .snakemake STARTED RESTART* QUEUED slurm*
touch COMPLETE 
