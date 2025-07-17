#!/bin/bash
#FLUX: --job-name=muffled-leopard-7159
#FLUX: --queue=hci-rw
#FLUX: -t=172800
#FLUX: --urgency=16

set -e; start=$(date +'%s'); rm -f FAILED COMPLETE QUEUED; touch STARTED
module load singularity/3.6.4
dataBundle=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/TNRunner
myData=/scratch/general/pe-nfs1/u0028003
container=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/TNRunner/Containers/public_SnakeMakeBioApps_5.sif
echo -e "\n---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
name=${PWD##*/}
jobDir=`readlink -f .`
SINGULARITYENV_name=$name SINGULARITYENV_jobDir=$jobDir SINGULARITYENV_dataBundle=$dataBundle \
singularity exec --containall --bind $dataBundle,$myData $container \
bash $jobDir/*.sing
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
mkdir -p RunScripts
mv somaticCaller* RunScripts/
mv -f slurm* Logs/ || true
rm -rf .snakemake 
rm -f FAILED STARTED DONE RESTART
touch COMPLETE 
