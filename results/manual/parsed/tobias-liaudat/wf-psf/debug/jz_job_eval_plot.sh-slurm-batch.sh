#!/bin/bash
#SBATCH --job-name=rerun_metrics
#SBATCH --account=ynx@gpu
#SBATCH --output=rerun_metrics%j.out
#SBATCH --error=rerun_metrics%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --constraint=ntasks-per-node=1,v100-32g

module purge
module load tensorflow-gpu/py3/2.4.1
set -x
srun python -u $WORK/repo/wf-psf/debug/jz_helper_eval_plot_script.py 
