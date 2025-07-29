#!/bin/bash
#SBATCH --job-name=CNN_Burn
#SBATCH --account=43299_sp0039
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:tesla:2
#SBATCH --mem=180000
#SBATCH --time=06:00:00
#SBATCH --partition=Nvidia

module load tensorflow-gpu
RUNDIR=/storage02/43299_sp0039/burn_multi/
OUTDIR=/storage02/43299_sp0039/burn_multi/output
python ${RUNDIR}/GPU.py
python ${RUNDIR}/Model.py $RUNDIR
python ${RUNDIR}/Evaluation.py $RUNDIR $OUTDIR
