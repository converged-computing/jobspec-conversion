#!/bin/bash
#FLUX: --job-name=first_4
#FLUX: -t=21600
#FLUX: --priority=16

module load buildtool-easybuild/4.5.3-nsce8837e7
module load foss/2020b
module load Anaconda/2021.05-nsc1
conda activate ds-envsci-env
python "/home/x_swakh/tools/HoliSoils/Scripts/Linux/transient/Run_scripts/gen_spec_lognorm_0_5/carbon_switch_off_competition_adaptation.py" --sim_label "competition_adaptation" --seeds_num 610229235 983307757 643338060 714504443
