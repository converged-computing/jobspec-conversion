#!/bin/bash
#FLUX: --job-name=AQM			       # How is your output is called, you name it.
#FLUX: --priority=16

source ~/miniconda3/etc/profile.d/conda.sh
conda activate base                             # Update this field to tne conda environment you wish to use for the run
python problem1_pure_python_parallel_zoom_sections.py # Ex if you have two parameters for every job, so it's ${pA[0]} ${pA[1]}
