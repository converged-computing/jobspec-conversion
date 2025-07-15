#!/bin/bash
#FLUX: --job-name=sim_proc_0_01
#FLUX: -t=36000
#FLUX: --priority=16

module load buildtool-easybuild/4.5.3-nsce8837e7
module load foss/2020b
module load Anaconda/2021.05-nsc1
conda activate ds-envsci-env
python "/home/x_swakh/tools/HoliSoils/Scripts/Linux/transient/Simulation_processing/decay_const_diff_c_pools.py" "gen_spec_lognorm_0_01"
