#!/bin/bash
#FLUX: --job-name=runGA
#FLUX: --queue=thrust2
#FLUX: -t=5184000
#FLUX: --urgency=16

module load MATLAB
./runHeadless.sh MatlabRun
