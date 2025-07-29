#!/bin/bash
#FLUX --job-name=pusheena-snack-1959
#FLUX -c=5
#FLUX --exclusive
#FLUX -t=21600
#FLUX --urgency=16

echo STARTING AT `date`
module purge
module load matlab
matlab -nosplash -nodisplay -nodesktop -r MAP2D_simple
cat /proc/cpuinfo | head -6
echo FINISHED at `date`
