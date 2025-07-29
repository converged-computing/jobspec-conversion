#!/bin/bash
#SBATCH --job-name=build-point-clouds
#SBATCH --output=build-point-clouds-%A-%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --array=0-4

set -euo pipefail
IFS=$'\n\t'
PART=${PART:-1}
echo $PWD
echo "SLURM_ARRAY_JOB_ID=$SLURM_ARRAY_JOB_ID"
echo "SLURM_ARRAY_TASK_ID=$SLURM_ARRAY_TASK_ID"
echo "Executing on machine: $(hostname)"
echo "Part: ${PART}"
python \
  build_point_clouds.py \
  --indir /scratch/gpfs/IOJALVO/gnn-tracking/object_condensation/codalab-data/part_${PART} \
  --outdir /scratch/gpfs/IOJALVO/gnn-tracking/object_condensation/point_clouds_v6/part_${PART} \
  --batch-size 210
echo "Finished"
