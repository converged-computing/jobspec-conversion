#!/bin/bash
#SBATCH --job-name=runs_analysis
#SBATCH --account=wpd@v100
#SBATCH --output=log/index_%a.job_%x.job_id_%j.master_id_%A.array_id_%a.out
#SBATCH --error=log/index_%a.job_%x.job_id_%j.master_id_%A.array_id_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --qos=qos_gpu-t3
#SBATCH --array=4096

module purge
module load cpuarch/amd
module load pytorch-gpu/py3/1.11.0
PATH=$PATH:~/.local/bin
export PATH
set -x
srun python -u command_line_tester.py --run_analysis_config_name _SPD_from_EEG_base_runs_analysis_config.yaml
