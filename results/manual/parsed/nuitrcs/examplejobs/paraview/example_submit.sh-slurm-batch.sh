#!/bin/bash
#FLUX: --job-name=sample_job
#FLUX: -N=2
#FLUX: --queue=short
#FLUX: -t=600
#FLUX: --urgency=16

module purge all
module load paraview/5.9.0
mpi-pvbatch test-pvbatch.py
