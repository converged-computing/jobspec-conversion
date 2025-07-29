#!/bin/bash
#SBATCH --job-name=argoverse
#SBATCH --output=log/argo_%A_%a.out
#SBATCH --error=log/argo_%A_%a.err
#SBATCH --mail-user=xl3136@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=12GB
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-23

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
