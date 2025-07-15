#!/bin/bash
#FLUX: --job-name=peachy-parsnip-2262
#FLUX: -c=2
#FLUX: -t=43260
#FLUX: --urgency=16

export FREESURFER_HOME='/cluster/projects/p23/tools/mri/freesurfer/freesurfer.6.0.0'
export SUBJECTS_DIR='${1}/subjects'
export HOME='$odir'

echo "LOADING MATLAB MODULE"
module load matlab/R2018a
echo `which matlab`
echo "SOURCING FSL"
FSLDIR=/cluster/projects/p23/tools/mri/fsl/current
. ${FSLDIR}/etc/fslconf/fsl.sh
PATH=${FSLDIR}/bin:${PATH}
export FSLDIR PATH
echo "SOURCING FREESURFER"
export FREESURFER_HOME=/cluster/projects/p23/tools/mri/freesurfer/freesurfer.6.0.0
source $FREESURFER_HOME/SetUpFreeSurfer.sh
export SUBJECTS_DIR=${1}/subjects
wdir=${1} 
adir=${2}
sdir=${3}
odir=${4}
Y=${5}
Qdec=${6}
subj=${7}
surf=${8}
mask=${9}
cohort=${10}
f=${11}
echo -e "
1 = $(echo $wdir)
2 = $(echo $adir)
3 = $(echo $sdir)
4 = $(echo $odir) 
5 = $(echo $Y)
6 = $(echo $Qdec)
7 = $(echo $subj)
8 = $(echo $surf)
9 = $(echo $mask)
10 = $(echo $cohort)
11 = $(echo $f)"
export HOME=$odir
matlab -nodisplay -r "PopAsym_LMM('$1', '$2', '$3', '$4', '$5', '$6', '$7', '$8', '$9', '$cohort', '$f')"
