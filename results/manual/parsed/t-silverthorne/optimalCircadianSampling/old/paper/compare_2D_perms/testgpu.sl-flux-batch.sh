#!/bin/bash
#FLUX: --job-name=testperms
#FLUX: -c=12
#FLUX: -t=120
#FLUX: --urgency=16

module load matlab/2022b.2
matlab -nodisplay -r "testgpu"
