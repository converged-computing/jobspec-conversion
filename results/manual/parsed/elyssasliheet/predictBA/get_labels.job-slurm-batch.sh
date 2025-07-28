#!/bin/bash
#FLUX: --job-name=get_labels
#FLUX: --exclusive
#FLUX: --queue=standard-s
#FLUX: --urgency=16

module load intel/2023.1
module load mpi
python get_labels.py
