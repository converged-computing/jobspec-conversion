#!/bin/bash
#FLUX: --job-name=grated-train-3837
#FLUX: --urgency=16

export OMP_NUM_THREADS='24'

export OMP_NUM_THREADS=24
cd $WORK
ibrun tacc_affinity ./lda_matlab_pso settings.cfg data_snr9_0232.map pso.cfg 66 data_snr9_0232.pso
