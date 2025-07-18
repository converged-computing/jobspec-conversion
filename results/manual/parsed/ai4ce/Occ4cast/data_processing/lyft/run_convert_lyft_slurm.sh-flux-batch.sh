#!/bin/bash
#FLUX: --job-name=lyft
#FLUX: -c=12
#FLUX: -t=14400
#FLUX: --urgency=16

sleep $(( (RANDOM%10) + 1 )) # to avoid issues when submitting large amounts of jobs
DATA_PATH=/lyft/train
OUTPUT_PATH=/vast/xl3136/lyft_kitti/train
START=0
A_PRE=70
A_POST=70
P_PRE=10
P_POST=10
echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
module purge
cd /scratch/$USER/Occ4D/data_processing/lyft
singularity exec \
	    --overlay /scratch/$USER/environments/lyft.ext3:ro \
        --overlay /scratch/$USER/dataset/lyft/lyft.sqf:ro \
	    /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif \
	    /bin/bash -c "source /ext3/env.sh; 
        python convert_lyft_batch.py -d $DATA_PATH -o $OUTPUT_PATH -s $START -b ${SLURM_ARRAY_TASK_ID} --a_pre $A_PRE --a_post $A_POST --p_pre $P_PRE --p_post $P_POST"
