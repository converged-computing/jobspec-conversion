#!/bin/bash
#FLUX: --job-name=all_combine
#FLUX: -t=259200
#FLUX: --urgency=16

module load buildtool-easybuild/4.5.3-nsce8837e7
module load foss/2020b
module load Anaconda/2021.05-nsc1
conda activate ds-envsci-env
python "/home/x_swakh/tools/HoliSoils/Scripts/Linux/transient/Simulation_processing/Combine_all_datasets.py"
