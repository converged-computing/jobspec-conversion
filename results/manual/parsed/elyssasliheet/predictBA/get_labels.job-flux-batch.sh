#!/bin/bash
#FLUX: --job-name=red-destiny-0468
#FLUX: --exclusive
#FLUX: --priority=16

module load intel/2023.1
module load mpi
python get_labels.py
