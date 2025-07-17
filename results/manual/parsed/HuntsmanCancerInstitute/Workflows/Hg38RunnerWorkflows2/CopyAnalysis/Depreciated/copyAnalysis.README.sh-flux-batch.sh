#!/bin/bash
#FLUX: --job-name=phat-poo-1709
#FLUX: --queue=hci-rw
#FLUX: -t=86400
#FLUX: --urgency=16

set -e; start=$(date +'%s'); rm -f FAILED COMPLETE QUEUED; touch STARTED
which singularity &> /dev/null || module load singularity
dataBundle=$(grep dataBundle *.yaml | grep -v ^# | cut -d ' ' -f2)
container=$dataBundle/Containers/public_GATK_SM_1.sif
jobDir=`readlink -f .`
SINGULARITYENV_jobDir=$jobDir SINGULARITYENV_dataBundle=$dataBundle \
singularity exec --containall --bind $jobDir,$dataBundle $container \
bash $jobDir/*.sing
mkdir -p RunScripts
mv -f copyAnalysis*  RunScripts/ &> /dev/null || true
mv -f *.yaml RunScripts/ &> /dev/null || true
cp slurm* Logs/ &> /dev/null || true
mv -f *snakemake.stats.json Logs/ &> /dev/null || true
rm -rf .snakemake STARTED RESTART* QUEUED slurm*
