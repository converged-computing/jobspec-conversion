#!/bin/bash
#FLUX: --job-name=BrainAgeCV
#FLUX: -t=7200
#FLUX: --urgency=16

export FREESURFER_HOME='/cluster/projects/p274/tools/mri/freesurfer/current'
export LANG='en_US.utf8'

echo "SETTING UP COLOSSUS ENVIRONMENT"
echo "LOADING SINGULARITY MODULE"
module purge
module load R/3.6.3-foss-2020a
echo `which R`
module load matlab
echo `which matlab`
echo "SOURCING FREESURFER"
export FREESURFER_HOME=/cluster/projects/p274/tools/mri/freesurfer/current
source $FREESURFER_HOME/SetUpFreeSurfer.sh
echo "SOURCING FSL"
FSLDIR=/cluster/projects/p274/tools/mri/fsl/current
. ${FSLDIR}/etc/fslconf/fsl.sh
PATH=${FSLDIR}/bin:${PATH}
export FSLDIR PATH
export LANG=en_US.utf8
eta=${1}
max_depth=${2}
gamma=${3}
min_child_weight=${4}
nrounds=${5}
data_folder=${6}
sex_split=${7}
echo "$eta $max_depth $gamma $min_child_weight $nrounds $data_folder"
mv scripts/LifeBrain/logs_BrainAgeCV/slurm-${SLURM_JOBID}.txt scripts/LifeBrain/logs_BrainAgeCV/slurm.it.$i.txt
basefolder=/cluster/projects/p274/projects/p024-modes_of_variation
scriptsfolder=$basefolder/scripts/LifeBrain
Rscript $scriptsfolder/BrainAgeCV.R $eta $max_depth $gamma $min_child_weight $nrounds $data_folder $sex_split
