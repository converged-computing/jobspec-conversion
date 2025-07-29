#!/bin/bash
#SBATCH --output=joblogs/%A_%a.out
#SBATCH --error=joblogs/%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32000
#SBATCH --time=1-00:00:00
#SBATCH --partition=seas_dgx1

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
