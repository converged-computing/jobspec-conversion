#!/bin/bash
#SBATCH --account=m1727_g
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --qos=regular
#SBATCH --constraint=gpu,ntasks-per-node=1
#SBATCH --array=0-9

module load tensorflow/2.6.0
cd /pscratch/sd/d/dlan/result_paper_IA_0/jac_ps_multiscale/
python /global/homes/d/dlan/DifferentiableHOS/scripts/compute_statistics.py  --filename=res_maps_0_$SLURM_ARRAY_TASK_ID --Power_Spectrum=True --Aia=0.
