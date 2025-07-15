#!/bin/bash
#FLUX: --job-name=argoverse
#FLUX: -c=12
#FLUX: -t=28800
#FLUX: --priority=16

DATA_DIR=/vast/xl3136/argoverse-tracking/test
OUT_DIR=/vast/xl3136/argoverse_kitti/test
echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
module purge
cd /scratch/$USER/Occ4D/data_processing/argoverse
singularity exec \
    --overlay /scratch/$USER/environments/argoverse.ext3:ro \
    /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif \
    /bin/bash -c "source /ext3/env.sh; 
    python transform_batch.py --dataset_dir $DATA_DIR -o $OUT_DIR -i ${SLURM_ARRAY_TASK_ID}"
