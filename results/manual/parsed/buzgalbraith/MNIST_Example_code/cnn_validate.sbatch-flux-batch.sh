#!/bin/bash
#FLUX: --job-name=cnn_validation
#FLUX: -t=3600
#FLUX: --urgency=16

module purge ## purge modules that we are not using 
module load python/intel/3.8.6 ## load python module
python ./cnn_validate.py ## run python training script.
echo "Job finished at: `date`" ## print the date and time the job finished
