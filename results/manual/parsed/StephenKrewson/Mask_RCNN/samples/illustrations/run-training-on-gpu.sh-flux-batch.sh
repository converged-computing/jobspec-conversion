#!/bin/bash
#FLUX: --job-name=evasive-truffle-4376
#FLUX: --priority=16

module purge
module load Apps/Matlab/R2017b
echo "Starting..."
matlab -nodisplay -nosplash -nojvm -r 'try main(); catch; end; quit;'
echo "All done!"
