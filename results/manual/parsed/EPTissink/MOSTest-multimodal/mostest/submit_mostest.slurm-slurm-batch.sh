#!/bin/bash
#FLUX: --job-name=mostest
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --urgency=16

set -o errexit
source ../settings.sh
module load matlab/R2018b
for MODALITY in T1 diffusion rsfmri multimodal; do
	# Set number of phenotypes
	if [ "$MODALITY" == "rsfmri" ]; then N_PHENO=139
	elif [ "$MODALITY" == "T1" ]; then N_PHENO=171
	elif [ "$MODALITY" == "diffusion" ]; then N_PHENO=272
	else N_PHENO=582; fi
	# Provide z-score matrix
	ZMAT_ORIG=\'${DATA}/zmat_discovery_${MODALITY}_orig_140522.dat\'
	ZMAT_PERM=\'${DATA}/zmat_discovery_${MODALITY}_perm_140522.dat\'
	# Run MOSTest
	matlab -nosplash -nodesktop -r "zmat_orig_file=${ZMAT_ORIG};zmat_perm_file=${ZMAT_PERM};num_eigval_to_keep=${SLURM_ARRAY_TASK_ID};out='${OUT}/${MODALITY}/${MODALITY}_mostest_eig${SLURM_ARRAY_TASK_ID}'; n_pheno=${N_PHENO}; mostest_multimodal; exit"
done
