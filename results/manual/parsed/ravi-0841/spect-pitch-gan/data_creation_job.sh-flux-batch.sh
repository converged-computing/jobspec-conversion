#!/bin/bash
#FLUX: --job-name=stinky-hippo-4614
#FLUX: --queue=shared
#FLUX: -t=1200
#FLUX: --urgency=16

module load matlab/R2018a
cd $HOME/data/ravi/spect-pitch-gan
matlab  -nodisplay -nosplash -r "generate_momenta $SLURM_ARRAY_TASK_ID cmu-arctic train;"
echo "matlab exit code: $?"
