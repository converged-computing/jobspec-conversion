#!/bin/bash
#FLUX: --job-name=gassy-pot-4616
#FLUX: -N=20
#FLUX: -n=1360
#FLUX: --queue=booster
#FLUX: -t=72000
#FLUX: --urgency=16

module --force purge
module load Architecture/KNL
module load intel-para
srun /p/project/cjiek63/jiek6304/JURECA_PFLOTRAN_280119/pflotran/src/pflotran/pflotran -pflotranin input_Permafrost.in
