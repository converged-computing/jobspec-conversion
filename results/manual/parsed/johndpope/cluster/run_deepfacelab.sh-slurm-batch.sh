#!/bin/bash
#FLUX: --job-name=run_deepfacelab
#FLUX: --queue=gtx1080
#FLUX: -t=25200
#FLUX: --urgency=16

echo "SLURM_JOBID"=$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
module load anaconda                          ### load anaconda module
source activate py37   
bash -i ./2_extract_image_from_data_src.sh
