#!/bin/bash
#FLUX: --job-name=loopy-peas-0054
#FLUX: --queue=hci-rw
#FLUX: --priority=16

set -e; start=$(date +'%s'); rm -f FAILED COMPLETE QUEUED; touch STARTED
module load singularity
dataBundle=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/TNRunner
container=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/TNRunner/Containers/public_Invitae_1.sif
echo -e "\n---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
jobDir=`readlink -f .`
SINGULARITYENV_jobDir=$jobDir SINGULARITYENV_dataBundle=$dataBundle \
singularity exec --containall --bind $dataBundle $container \
bash $jobDir/*.sing
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
mkdir -p RunScripts
mv invitae* RunScripts/
mv -f slurm* Logs/ || true
rm -rf .snakemake 
rm -f FAILED STARTED DONE RESTARTED
touch COMPLETE 
