#!/bin/bash
#FLUX: --job-name=runGA
#FLUX: --queue=thrust2
#FLUX: --priority=16

module load MATLAB
./runHeadless.sh MatlabRun
