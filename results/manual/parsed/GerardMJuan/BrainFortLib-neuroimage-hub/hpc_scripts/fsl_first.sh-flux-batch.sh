#!/bin/bash
#FLUX: --job-name=evasive-pastry-0246
#FLUX: --priority=16

export PATH='$HOME/project/anaconda3/bin:$PATH'

source /etc/profile.d/lmod.sh
source /etc/profile.d/easybuild.sh
module load libGLU
export PATH="$HOME/project/anaconda3/bin:$PATH"
source activate dlnn
FSLDIR=/homedtic/gmarti/LIB/fsl
. ${FSLDIR}/etc/fslconf/fsl.sh
PATH=${FSLDIR}/bin:${PATH}
export FSLDIR PATH
run_first_all -i /homedtic/gmarti/DATA/Data/quick_first_test/sub-ADNI002S0295_ses-M00_T1w.nii.gz -o /homedtic/gmarti/DATA/Data/quick_first_test/segmented
