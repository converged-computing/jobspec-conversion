#!/bin/bash
#FLUX: --job-name=pixsfm
#FLUX: -c=12
#FLUX: --queue=allgroups
#FLUX: -t=43200
#FLUX: --priority=16

cd $WORKING_DIR
srun singularity exec --writable --nv Master-Thesis-Structure-from-Motion/sif_files/pixsfm_1_0_4.sif python3 Master-Thesis-Structure-from-Motion/experiments/sfm_pixsfm/run.py /home/ghamsariki/Master-Thesis-Structure-from-Motion/pixsfm_project
