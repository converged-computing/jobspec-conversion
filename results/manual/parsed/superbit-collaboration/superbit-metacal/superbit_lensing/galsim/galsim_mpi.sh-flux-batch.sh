#!/bin/bash
#FLUX: --job-name=galsim-mpi-forecast
#FLUX: -N=3
#FLUX: -t=1800
#FLUX: --urgency=16

GALSIM_DIR=/users/jmcclear/data/superbit/superbit-metacal/GalSim
CONFIG_FILE=$GALSIM_DIR/superbit_parameters_debugforecast.yaml
srun --mpi=pmix python $GALSIM_DIR/mock_superBIT_data.py config_file=$CONFIG_FILE
