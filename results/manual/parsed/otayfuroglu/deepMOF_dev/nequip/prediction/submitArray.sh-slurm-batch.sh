#!/bin/bash
#SBATCH --job-name=nequip
#SBATCH --account=s1167
#SBATCH --output=log.out
#SBATCH --error=log.err
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=12
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1,gpu
#SBATCH --array=0-9

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module purge
module load daint-gpu
module load PyTorch
idx=$SLURM_ARRAY_TASK_ID
SCRIPT_DIR=/users/tayfurog/deepMOF_dev/nequip/prediction/
python $SCRIPT_DIR/calcFreeEwithNequip.py -extxyz_path vasp_opt_lowest_10_polymeric_24atoms.extxyz -idx $idx 
exit
