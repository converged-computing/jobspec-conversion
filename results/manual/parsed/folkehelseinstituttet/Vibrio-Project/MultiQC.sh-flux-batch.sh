#!/bin/bash
#FLUX: --job-name=AsmQC
#FLUX: -t=3600
#FLUX: --urgency=16

source /cluster/bin/jobsetup
module load Miniconda3/4.4.10
source activate MultiQC
time python MultiQC.py
source deactivate MultiQC
