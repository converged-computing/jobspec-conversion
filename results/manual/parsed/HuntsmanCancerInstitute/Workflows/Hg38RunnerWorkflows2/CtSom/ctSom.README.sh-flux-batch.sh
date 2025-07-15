#!/bin/bash
#FLUX: --job-name=spicy-motorcycle-4432
#FLUX: --queue=hci-rw
#FLUX: --urgency=16

set -e; start=$(date +'%s'); rm -f FAILED COMPLETE QUEUED; touch STARTED
module load singularity/3.2.0
singExec=/uufs/chpc.utah.edu/sys/installdir/singularity3/3.2.0/bin/singularity
dataBundle=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/TNRunner
myData=/scratch/mammoth/serial/u0028003
container=/uufs/chpc.utah.edu/common/HIPAA/u0028003/HCINix/SingularityBuilds/public_CtSom_1.sif
echo -e "\n---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
name=${PWD##*/}
jobDir=`readlink -f .`
SINGULARITYENV_name=$name SINGULARITYENV_jobDir=$jobDir SINGULARITYENV_dataBundle=$dataBundle \
$singExec exec --containall --bind $dataBundle,$myData $container \
bash $jobDir/*.sing
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
mkdir -p RunScripts
mv ctSom* RunScripts/
mv -f *.log  Logs/ || true
mv -f slurm* Logs/ || true
rm -rf .snakemake FAILED QUEUED STARTED DONE RESTART
touch COMPLETE 
