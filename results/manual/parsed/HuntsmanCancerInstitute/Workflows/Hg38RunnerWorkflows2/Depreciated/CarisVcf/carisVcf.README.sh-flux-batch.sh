#!/bin/bash
#FLUX: --job-name=salted-pedo-9081
#FLUX: --queue=hci-rw
#FLUX: --priority=16

set -e
which singularity &> /dev/null || module load singularity
dataBundle=$(grep dataBundle *.yaml | grep -v ^# | cut -d ' ' -f2)
container=$dataBundle/Containers/public_ILLUM_SM_1.sif
jobDir=`readlink -f .`
SINGULARITYENV_jobDir=$jobDir SINGULARITYENV_dataBundle=$dataBundle \
singularity exec --containall --bind $dataBundle,$jobDir $container \
bash $jobDir/*.sing
mkdir -p RunScripts
mv -f carisVcf.*  RunScripts/ &> /dev/null || true
mv -f *.yaml RunScripts/ &> /dev/null || true
cp slurm* Logs/ &> /dev/null || true
mv -f *snakemake.stats.json Logs/ &> /dev/null || true
rm -rf .snakemake STARTED RESTART* QUEUED slurm* 
touch COMPLETE
