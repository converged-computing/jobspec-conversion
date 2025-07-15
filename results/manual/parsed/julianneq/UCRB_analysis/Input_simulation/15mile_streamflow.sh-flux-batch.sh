#!/bin/bash
#FLUX: --job-name=streamflow
#FLUX: -N=8
#FLUX: --queue=compute
#FLUX: --urgency=16

module load python
module load mpi4py
module load scipy
ibrun python 15mile_streamflow.py LHsamples_original_1000
