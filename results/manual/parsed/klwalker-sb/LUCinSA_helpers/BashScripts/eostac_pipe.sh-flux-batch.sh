#!/bin/bash
#FLUX: --job-name="stpipe_crg"
#FLUX: --priority=16

export OPENBLAS_NUM_THREADS='1'
export MKL_NUM_THREADS='1'
export OMP_NUM_THREADS='1'

GRIDS="$(($SLURM_ARRAY_TASK_ID + 3000))"
export OPENBLAS_NUM_THREADS=1
export MKL_NUM_THREADS=1
export OMP_NUM_THREADS=1
STEP="preprocess"
SAT_SENSORS=S2,S2cp,LT05,LE07,LC08,LC09
NCHUNKS=512
RERUN="True"
conda activate .lucinla38_pipe
CONFIG_UPDATES="grids:[${GRIDS}] res:${REF_RES} crs:${REF_CRS} 
cloud_mask:sat_sensors:${SAT_SENSORS}
cloud_mask:reset_db:${RERUN}
main_path:/home/sandbox-cel/paraguay_lc/stac/grid
backup_path:/home/downspout-cel/paraguay_lc/stac/grids
num_workers:${SLURM_CPUS_ON_NODE} 
io:n_chunks:${NCHUNKS} cloud_mask:reset_db:${RESET_CLOUD_DB} 
cloud_mask:ref_res:${REF_RES}"
tuyau $STEP --config-updates $CONFIG_UPDATES
conda source deactivate
