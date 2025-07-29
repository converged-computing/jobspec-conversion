#!/bin/bash
#SBATCH --job-name=bc
#SBATCH --output=logs/%A_%a_%x.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32GB
#SBATCH --time=03:00:00
#SBATCH --array=0,1,2

modes=("expert" "mixed-const" "mixed-exp")
mode=${modes[${SLURM_ARRAY_TASK_ID}]}
singularity exec \
    --overlay /scratch/nv2099/images/overlay-50G-10M.ext3:ro \
    /scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif \
    /bin/bash -c "
    source /ext3/miniconda3/etc/profile.d/conda.sh;
    conda activate mcs;
    cd /home/nv2099/projects/mcs;
    python -u leduc_bc.py --traj trajectories/traj-${mode}--1e+06.csv --label ${mode}/ep_20_lr_5e-5;
    "
