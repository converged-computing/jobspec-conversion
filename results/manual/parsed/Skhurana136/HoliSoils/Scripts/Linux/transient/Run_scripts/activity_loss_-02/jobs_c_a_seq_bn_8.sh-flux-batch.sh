#!/bin/bash
#FLUX: --job-name=c_a_seq_8
#FLUX: -t=36000
#FLUX: --priority=16

module load buildtool-easybuild/4.5.3-nsce8837e7
module load foss/2020b
module load Anaconda/2021.05-nsc1
conda activate ds-envsci-env
python "/home/x_swakh/tools/HoliSoils/Scripts/Linux/transient/Run_scripts/activity_loss_-02/carbon_switch_off_competition_adaptation_seq_bn_8.py" "competition_adaptation_seq_8"
