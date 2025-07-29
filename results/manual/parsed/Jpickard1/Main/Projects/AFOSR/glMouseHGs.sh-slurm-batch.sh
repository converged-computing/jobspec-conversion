#!/bin/bash
#FLUX: --job-name=mouseHGs
#FLUX: --queue=standard
#FLUX: -t=345600
#FLUX: --urgency=16

module load matlab
matlab -nodisplay -r "mouseCodes/scratch2($SLURM_ARRAY_TASK_ID)"
