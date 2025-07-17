#!/bin/bash
#FLUX: --job-name=creamy-cupcake-0012
#FLUX: -n=2
#FLUX: --queue=priority
#FLUX: -t=5400
#FLUX: --urgency=16

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load matlab/2017a
matlab -nodisplay -r "spkParse96well; quit"
