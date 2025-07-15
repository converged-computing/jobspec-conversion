#!/bin/bash
#FLUX: --job-name=runGA
#FLUX: --queue=thrust2
#FLUX: --urgency=16

module load MATLAB
./runHeadless.sh MatlabRun
