#!/bin/bash
#FLUX: --job-name=resp_0_01
#FLUX: -t=259200
#FLUX: --priority=16

module load buildtool-easybuild/4.5.3-nsce8837e7
module load foss/2020b
module load Anaconda/2021.05-nsc1
conda activate ds-envsci-env
python "/home/x_swakh/tools/HoliSoils/Scripts/Linux/transient/Simulation_processing/calculate_respiration.py" "gen_spec_lognorm_0_01"
