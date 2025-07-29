#!/bin/bash
#SBATCH --job-name=sim
#SBATCH --mail-user=jd18380@bristol.ac.uk
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --partition=gpu

export EXE='/bin/hostname'

export EXE=/bin/hostname
cd "${SLURM_SUBMIT_DIR}"
${EXE}
echo JOB ID: ${SLURM_JOBID}
echo Working Directory: $(pwd)
echo Start Time: $(date)
nvidia-smi --query-gpu=name --format=csv,noheader
source ../.venv/bin/activate
python $1 ${@:2}
echo End Time: $(date)
