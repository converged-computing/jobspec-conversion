#!/bin/bash
#FLUX: --job-name=CliERA5_dwn
#FLUX: --queue=huce_intel
#FLUX: -t=86400
#FLUX: --urgency=16

module load Anaconda3/5.0.1-fasrc02
source activate base_env
python $1
