#!/bin/bash
#FLUX: --job-name=astute-knife-1178
#FLUX: -n=40
#FLUX: --queue=small
#FLUX: -t=54610
#FLUX: --urgency=16

module load maestro parallel
find /scratch/project_xxxx/yetukuri/results_1000k_splits  -name '*.smi' | \
parallel -j 38 bash ${SLURM_SUBMIT_DIR}/wrapper_ligprep_pipeline.sh {} 
