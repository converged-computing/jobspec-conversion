#!/bin/bash
#FLUX: --job-name=ABQPlot
#FLUX: --queue=fat
#FLUX: -t=64800
#FLUX: --urgency=16

module load easybuild
module load prl
module load python/3.6.0
cd /home/abubie/qual_ind_swp
./Qual_Mean_Calc.py
echo $"Qual plot is complete"
