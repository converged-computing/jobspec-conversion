#!/bin/bash
#FLUX: --job-name=swat_callib_mpi_x
#FLUX: --queue=main
#FLUX: -t=604800
#FLUX: --urgency=16

module load openmpi-3.1.0
module load python-3.7.1
source activate daskgeo2020a
mpirun python run_for.py -m $MD1 -s $SP1 -r $REP1 -p $PAR1
