#!/bin/bash
#FLUX: --job-name=fuzzy-bits-1594
#FLUX: -c=4
#FLUX: -t=18000
#FLUX: --urgency=16

module purge
module load Apps/Matlab/R2017b
echo "Starting..."
matlab -nodisplay -nosplash -nojvm -r 'try main(); catch; end; quit;'
echo "All done!"
