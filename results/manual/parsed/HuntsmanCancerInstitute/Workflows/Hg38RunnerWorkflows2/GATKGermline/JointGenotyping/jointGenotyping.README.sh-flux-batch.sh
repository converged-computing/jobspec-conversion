#!/bin/bash
#FLUX: --job-name=pusheena-caramel-7170
#FLUX: --queue=hci-rw
#FLUX: -t=345600
#FLUX: --urgency=16

set -e
which singularity &> /dev/null || module load singularity
dataBundle=$(grep dataBundle *.yaml | grep -v ^# | cut -d ' ' -f2)
container=$dataBundle/Containers/public_GATK_SM_1.sif
jobDir=$(realpath .)
tmpDir=/scratch/local/$USER/$SLURM_JOB_ID/JointGenotypingTmp
rm -rf $tmpDir; mkdir -p $tmpDir &> /dev/null || true
if [ ! -d $tmpDir ]; then
    tmpDir=$jobDir"/JointGenotypingTmp"; rm -rf $tmpDir; mkdir $tmpDir
fi
SINGULARITYENV_dataBundle=$dataBundle SINGULARITYENV_jobDir=$jobDir SINGULARITYENV_tmpDir=$tmpDir \
singularity exec --containall --bind $dataBundle,$tmpDir $container bash $jobDir/*.sing
