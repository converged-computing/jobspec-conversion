#!/bin/bash
#FLUX: --job-name=bio_char_0_5
#FLUX: -t=36000
#FLUX: --priority=16

module load buildtool-easybuild/4.5.3-nsce8837e7
module load foss/2020b
module load Anaconda/2021.05-nsc1
conda activate ds-envsci-env
python "/home/x_swakh/tools/HoliSoils/Scripts/Linux/transient/Simulation_processing/max_bio_char.py" "gen_spec_lognorm_0_5"
