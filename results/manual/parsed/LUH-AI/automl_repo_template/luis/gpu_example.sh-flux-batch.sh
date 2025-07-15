#!/bin/bash
#FLUX: --job-name=test_gpu
#FLUX: --queue=ai,ainlp,tnt
#FLUX: -t=300
#FLUX: --priority=16

module load GCC/10.3.0
module load CMake/3.20.1
conda activate myenv
{%- if cookiecutter.command_line_interface|lower == 'hydra' %}
python cli.py id=$SLURM_ARRAY_TASK_ID{%- else %}
python cli.py --id $SLURM_ARRAY_TASK_ID{% endif %}
