#!/bin/bash
#FLUX: --job-name=goodbye-salad-3672
#FLUX: -N=20
#FLUX: -n=1360
#FLUX: --queue=booster
#FLUX: -t=72000
#FLUX: --priority=16

module --force purge
module load Architecture/KNL
module load intel-para
srun /p/project/cjiek63/jiek6304/JURECA_PFLOTRAN_280119/pflotran/src/pflotran/pflotran -pflotranin input_Permafrost.in
