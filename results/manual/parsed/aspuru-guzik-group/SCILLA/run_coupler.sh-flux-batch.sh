#!/bin/bash
#FLUX: --job-name=run_coupler
#FLUX: -c=64
#FLUX: --queue=unrestricted
#FLUX: -t=172800
#FLUX: --urgency=16

module load centos6/0.0.1-fasrc01
module load Anaconda3/5.0.1-fasrc01
module load mathematica/11.1.1-fasrc01
source activate Qcirc
python circuit_searcher.py
echo Finished!
