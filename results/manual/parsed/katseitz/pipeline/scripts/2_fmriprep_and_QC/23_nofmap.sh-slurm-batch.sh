#!/bin/bash
#FLUX: --job-name=fno_fmap
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load singularity/latest
echo "modules loaded" 
echo "beginning preprocessing"
singularity run --cleanenv -B /projects/b1108:/projects/b1108 \
-B /projects/b1108/studies/transitions2/data/processed/neuroimaging/fmriprep_ses-1:/out \
-B /projects/b1108/studies/transitions2/data/raw/neuroimaging/bids:/data \
-B /projects/b1108/studies/transitions2/data/processed/neuroimaging/fmriprep_ses-1/work:/work \
/projects/b1108/software/singularity_images/fmriprep-23.0.1.simg \
/data /out participant \
--participant-label ${1} --bids-filter-file bids_filter_file_ses-1.json \
--fs-license-file /projects/b1108/software/freesurfer_license/license.txt \
-w /work --ignore fieldmaps --skip_bids_validation
