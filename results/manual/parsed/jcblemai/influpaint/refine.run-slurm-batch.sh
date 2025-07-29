#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --array=1,2,3

module purge
/nas/longleaf/home/chadi/.conda/envs/diffusion_torch6/bin/python -u main_refine.py --spec_id ${SLURM_ARRAY_TASK_ID} --inpaint True > out_refine_${SLURM_ARRAY_TASK_ID}.out 2>&1
