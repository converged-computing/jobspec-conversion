#!/bin/bash
#FLUX: --job-name=tart-malarkey-2058
#FLUX: --urgency=16

export GPAW_SETUP_PATH='$GPAW_SETUP_PATH:./'

module purge
module load intel/2017b GPAW/1.3.0-Python-2.7.14
export GPAW_SETUP_PATH=$GPAW_SETUP_PATH:/c3se/apps/Glenn/gpaw/gpaw-setups-0.9.11271/
export GPAW_SETUP_PATH=$GPAW_SETUP_PATH:./
mpirun gpaw-python ./HA3_4.py
