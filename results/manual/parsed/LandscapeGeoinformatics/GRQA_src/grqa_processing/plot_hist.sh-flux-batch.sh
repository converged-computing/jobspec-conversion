#!/bin/bash
#FLUX: --job-name=plot_hist
#FLUX: -N=4
#FLUX: --queue=amd
#FLUX: -t=3600
#FLUX: --urgency=16

cd /gpfs/terra/export/samba/gis/holgerv/river_quality/scripts/grqa_processing
module purge
module load python
source activate river_quality
code_file="/gpfs/terra/export/samba/gis/holgerv/GRQA_v1.3/GRQA_meta/GRQA_param_codes.txt"
readarray param_codes < ${code_file}
param_code=${param_codes[$SLURM_ARRAY_TASK_ID]}
~/.conda/envs/river_quality/bin/python plot_hist.py ${param_code}
