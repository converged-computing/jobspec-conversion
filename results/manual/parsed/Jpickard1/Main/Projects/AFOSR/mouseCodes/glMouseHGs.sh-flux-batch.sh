#!/bin/bash
#FLUX: --job-name=mouseHGs
#FLUX: --queue=standard
#FLUX: -t=345600
#FLUX: --priority=16

module load matlab
matlab -nodisplay -r "scratch2($SLURM_ARRAY_TASK_ID)"
