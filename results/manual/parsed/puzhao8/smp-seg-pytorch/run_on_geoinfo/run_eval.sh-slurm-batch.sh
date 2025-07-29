#!/bin/bash
#SBATCH --job-name=eval
#SBATCH --output=/home/p/u/puzhao/smp-seg-pytorch/run_logs/%x-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=36GB
#SBATCH --time=7-00:00:00

echo "start"
echo "Starting job ${SLURM_JOB_ID} on ${SLURMD_NODENAME}"
echo
nvidia-smi
. /geoinfo_vol1/puzhao/miniforge3/etc/profile.d/conda.sh
conda activate pytorch
PYTHONUNBUFFERED=1; 
python3 s1s2_evaluator_prg.py \
            --config-name=s1s2_cfg_prg.yaml \
            DATA.SATELLITES=['S1'] \
            DATA.INPUT_BANDS.S2=['B4','B8','B12'] \
echo "finish"
