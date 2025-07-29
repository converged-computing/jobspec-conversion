#!/bin/bash
#SBATCH --job-name=fsl
#SBATCH --output=LOGS/first%J.out
#SBATCH --error=LOGS/first%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --chdir=/homedtic/gmarti/

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
