#!/bin/bash
#SBATCH --job-name=preproc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --partition=shared

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
