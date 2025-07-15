#!/bin/bash
#FLUX: --job-name=crusty-sundae-4589
#FLUX: --exclusive
#FLUX: --urgency=16

module load intel/2023.1
module load mpi
python get_labels.py
