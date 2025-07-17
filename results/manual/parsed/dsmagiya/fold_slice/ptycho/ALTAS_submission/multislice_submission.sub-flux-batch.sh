#!/bin/bash
#FLUX: --job-name=test_job
#FLUX: -c=32
#FLUX: -t=36000
#FLUX: --urgency=16

pwd; hostname; date
echo "SLURM_ARRAY JOB ID is $SLURM_ARRAY_JOB_ID."
echo "SLURM_ARRAY TASK ID is $SLURM_ARRAY_TASK_ID"
module load matlab/R2021a
module load cuda/11.5
EXEPATH='/home/fs01/cz489/fold_slice/ptycho/'
PARFILE='/home/fs01/cz489/ptychography/jobs/multislice_example/parameter_multislice.txt'
matlab -nodisplay -nosplash -r "cd ~;\
	cd $EXEPATH;\
	prepare_data('$PARFILE');\
	run_multislice_new('$PARFILE');\
	exit"
date
