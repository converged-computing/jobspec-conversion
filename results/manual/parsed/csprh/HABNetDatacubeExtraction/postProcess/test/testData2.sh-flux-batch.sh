#!/bin/bash
#FLUX: --job-name=test_job
#FLUX: --queue=test
#FLUX: --urgency=16

module load CUDA
module load apps/matlab/2017a
cd $SLURM_SUBMIT_DIR
echo $SLURM_SUBMIT_DIR
cd /mnt/storage/home/csprh/code/HAB/extractData/postProcess
matlab -nodisplay -nosplash -r cubeAnalysis_1
