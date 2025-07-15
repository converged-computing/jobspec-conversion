#!/bin/bash
#FLUX: --job-name=stinky-latke-3848
#FLUX: -t=86400
#FLUX: --urgency=16

module load Anaconda3/5.3.0
module load fosscuda/2019b  # includes GCC 8.3
module load imkl/2019.5.281-iimpi-2019b
module load CMake/3.15.3-GCCcore-8.3.0
source activate speechbrain
srun --export=ALL python3 create_whamr_rirs.py --output-dir ~/fastdata/data/whamr/rirs
