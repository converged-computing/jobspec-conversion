#!/bin/bash
#FLUX: --job-name=sim_proc_0_1
#FLUX: -t=36000
#FLUX: --urgency=16

module load buildtool-easybuild/4.5.3-nsce8837e7
module load foss/2020b
module load Anaconda/2021.05-nsc1
conda activate ds-envsci-env
python "/home/x_swakh/tools/HoliSoils/Scripts/Linux/transient/Simulation_processing/decay_const_diff_c_pools_time_initial_conditions.py" "gen_spec_lognorm_0_1"
