#!/bin/bash
#FLUX: --job-name=bl_analysis
#FLUX: --priority=16

module purge
module load anaconda
conda --version
source activate mosdef-study38
python bl_analysis_overall.py
