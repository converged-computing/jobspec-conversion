#!/bin/bash
#FLUX: --job-name=angry-staircase-5572
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

module load tensorflow/2.6.0
cd /pscratch/sd/d/dlan/result_paper_IA_0/jac_ps_multiscale/
python /global/homes/d/dlan/DifferentiableHOS/scripts/compute_statistics.py  --filename=res_maps_0_$SLURM_ARRAY_TASK_ID --Power_Spectrum=True --Aia=0.
