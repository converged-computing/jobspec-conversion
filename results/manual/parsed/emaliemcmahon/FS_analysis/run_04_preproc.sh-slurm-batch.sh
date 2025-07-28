#!/bin/bash
#FLUX: --job-name=preproc
#FLUX: --queue=shared
#FLUX: -t=36000
#FLUX: --urgency=16

sid=$1
module load matlab
module load freesurfer
source ~/work/mcmahoneg/mri_data_anlys/studies/cont_actions/analysis/SetUpFreeSurfer.sh
preproc-sess \
	-s ${sid} \
	-df sessdir \
	-per-run \
	-fsd bold \
	-fwhm 0 \
	-force 
mv *.out ./slurm_out/
