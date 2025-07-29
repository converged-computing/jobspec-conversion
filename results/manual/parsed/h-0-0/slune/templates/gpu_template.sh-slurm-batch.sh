#!/bin/bash
#SBATCH --job-name=my_job_name
#SBATCH --output=my_job_output.log
#SBATCH --error=my_job_error.log
#SBATCH --mail-user=your@email.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00

export EXE='/bin/hostname'

export EXE=/bin/hostname
cd "${SLURM_SUBMIT_DIR}"
${EXE}
echo JOB ID: ${SLURM_JOBID}
echo Working Directory: $(pwd)
echo Start Time: $(date)
nvidia-smi --query-gpu=name --format=csv,noheader
source ../pyvenv/bin/activate
python $1 ${@:2}
echo End Time: $(date)
