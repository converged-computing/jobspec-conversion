#!/bin/bash
#FLUX: --job-name=strawberry-cattywampus-1348
#FLUX: --queue=hci-rw
#FLUX: -t=345600
#FLUX: --urgency=16

set -e
which singularity &> /dev/null || module load singularity
dataBundle=$(grep dataBundle *.yaml | grep -v ^# | cut -d ' ' -f2)
container=$dataBundle/Containers/public_GATK_SM_1.sif
jobDir=$(realpath .)
tmpDir=/scratch/local/$USER/$SLURM_JOB_ID/HaplotypeCallingTmp
rm -rf $tmpDir; mkdir -p $tmpDir &> /dev/null || true
if [ ! -d $tmpDir ]; then
    tmpDir=$jobDir"/HaplotypeCallingTmp"; rm -rf $tmpDir; mkdir $tmpDir
fi
SINGULARITYENV_tmpDir=$tmpDir SINGULARITYENV_dataBundle=$dataBundle SINGULARITYENV_jobDir=$jobDir \
singularity exec --containall --bind $dataBundle,$jobDir,$tmpDir $container bash $jobDir/*.sing
