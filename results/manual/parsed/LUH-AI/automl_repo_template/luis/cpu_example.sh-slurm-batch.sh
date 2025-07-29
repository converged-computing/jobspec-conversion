#!/bin/bash
#SBATCH --job-name=test_job_array
#SBATCH --output=test_array-job_%A_%a.out
#SBATCH --error=test_array-job_%A_%a.err
#SBATCH --mail-user=<y.name>@ai.uni-hannover.de
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10M
#SBATCH --time=00:05:00
#SBATCH --partition=ai,tnt
#SBATCH --array=10-12,18

module load GCC/10.3.0
module load CMake/3.20.1
conda activate myenv
{%- if cookiecutter.command_line_interface|lower == 'hydra' %}
python cli.py id=$SLURM_ARRAY_TASK_ID{%- else %}
python cli.py --id $SLURM_ARRAY_TASK_ID{% endif %}
