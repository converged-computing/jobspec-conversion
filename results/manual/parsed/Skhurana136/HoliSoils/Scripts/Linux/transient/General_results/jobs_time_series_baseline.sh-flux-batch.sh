#!/bin/bash
#FLUX: --job-name=base_tim
#FLUX: -t=36000
#FLUX: --urgency=16

module load buildtool-easybuild/4.5.3-nsce8837e7
module load foss/2020b
module load Anaconda/2021.05-nsc1
conda activate ds-envsci-env
python "/home/x_swakh/tools/HoliSoils/Scripts/Linux/transient/General_results/Time_series_baseline.py" "competition_adaptation"
