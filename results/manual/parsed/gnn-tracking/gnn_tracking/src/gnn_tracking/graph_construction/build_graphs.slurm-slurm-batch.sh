#!/bin/bash
#FLUX: --job-name=build-graphs
#FLUX: -t=10800
#FLUX: --urgency=16

set -euo pipefail
IFS=$'\n\t'
PART=${PART:-1}
echo $PWD
echo "SLURM_ARRAY_JOB_ID=$SLURM_ARRAY_JOB_ID"
echo "SLURM_ARRAY_TASK_ID=$SLURM_ARRAY_TASK_ID"
echo "Executing on machine: $(hostname)"
echo "Part: ${PART}"
python build_graphs.py \
  --indir /scratch/gpfs/IOJALVO/gnn-tracking/object_condensation/point_clouds_v2/part_${PART} \
  --outdir /scratch/gpfs/IOJALVO/gnn-tracking/object_condensation/graphs_v3/part_${PART} \
  --batch-size 48
echo "Finished"
