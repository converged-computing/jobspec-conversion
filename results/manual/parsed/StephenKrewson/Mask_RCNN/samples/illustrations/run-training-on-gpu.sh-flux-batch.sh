#!/bin/bash
#FLUX: --job-name=chocolate-sundae-4613
#FLUX: -c=4
#FLUX: -t=18000
#FLUX: --urgency=16

module purge
module load Apps/Matlab/R2017b
echo "Starting..."
matlab -nodisplay -nosplash -nojvm -r 'try main(); catch; end; quit;'
echo "All done!"
