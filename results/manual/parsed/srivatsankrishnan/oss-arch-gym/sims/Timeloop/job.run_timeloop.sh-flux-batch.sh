#!/bin/bash
#FLUX: --job-name=bloated-spoon-9127
#FLUX: -n=32
#FLUX: --queue=seas_dgx1
#FLUX: -t=86400
#FLUX: --urgency=16

export USER_UID='$UID'
export USER_GID='$(id -g)'

set -x
date
cdir=$(pwd)
outputdir="${cdir}/output/${SLURM_JOB_ID}"
mkdir -p $outputdir
echo $outputdir
mapperdir="/scratch/susobhan/${SLURM_JOB_ID}/mapper"
mkdir -p $mapperdir
cp -r ./mapper/mapper.yaml $mapperdir
archdir="/scratch/susobhan/${SLURM_JOB_ID}/arch"
mkdir -p $archdir
cp -r ./arch/* $archdir
scriptdir="/scratch/susobhan/${SLURM_JOB_ID}/script"
mkdir -p $scriptdir
cp -r ./script/* $scriptdir
settingsdir="/scratch/susobhan/${SLURM_JOB_ID}/settings"
mkdir -p $settingsdir
cp /n/janapa_reddi_lab/Lab/susobhan/arch-gym/settings/default_timeloop.yaml $settingsdir
source /n/home12/susobhan/.bashrc
conda activate /n/home12/susobhan/.conda/envs/arch-gym
export USER_UID=$UID
export USER_GID=$(id -g)
python collect_data.py ${SLURM_ARRAY_TASK_ID} $outputdir $mapperdir $archdir $scriptdir $settingsdir
