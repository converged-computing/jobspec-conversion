#!/bin/bash
#FLUX: --job-name=lovable-peanut-9031
#FLUX: --urgency=16

module purge
module load Apps/Matlab/R2017b
echo "Starting..."
matlab -nodisplay -nosplash -nojvm -r 'try main(); catch; end; quit;'
echo "All done!"
