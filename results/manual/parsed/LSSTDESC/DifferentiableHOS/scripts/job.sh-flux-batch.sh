#!/bin/bash
#FLUX: --job-name=purple-poo-5332
#FLUX: --gpus-per-task=1
#FLUX: -t=21600
#FLUX: --urgency=16

module load tensorflow/2.6.0
cd /pscratch/sd/d/dlan/result_paper_IA_0/jac_ps_multiscale/
python /global/homes/d/dlan/DifferentiableHOS/scripts/compute_statistics.py  --filename=res_maps_0_$SLURM_ARRAY_TASK_ID --Power_Spectrum=True --Aia=0.
