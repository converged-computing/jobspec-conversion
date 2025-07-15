#!/bin/bash
#FLUX: --job-name=stanky-earthworm-2715
#FLUX: --priority=16

export PATH='$HOME/project/anaconda3/bin:$PATH'

source /etc/profile.d/lmod.sh
source /etc/profile.d/easybuild.sh
module load libGLU
export PATH="$HOME/project/anaconda3/bin:$PATH"
source activate dlnn
BASE_DIR="/homedtic/gmarti/DATA/Data/ADNI_BIDS"	    # dir containing BIDS data
SCRIPTS_DIR="/homedtic/gmarti/CODE/upf-nii/scripts"	# dir containing the scripts
N_THREADS="60"                                       # N of threads for parallel comp.
TEMPLATE="/homedtic/gmarti/DATA/MNI152/icbm_avg_152_t1_tal_nlin_symmetric_VI.nii"
python /homedtic/gmarti/CODE/upf-nii/scripts/quick_scripts/visualize_slices.py --input_dir /homedtic/gmarti/DATA/Data/ADNI_BIDS/derivatives/registered_baseline --in_suffix .nii.gz --out_dir  /homedtic/gmarti/DATA/Data/registered_baseline_samples/
