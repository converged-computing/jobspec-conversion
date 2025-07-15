#!/bin/bash
#FLUX: --job-name=hello-bits-3689
#FLUX: -N=8
#FLUX: --queue=snb
#FLUX: -t=46800
#FLUX: --urgency=16

export OMP_NUM_THREADS='16'
export mpi_ranks='8'

source /etc/profile.d/modules.sh
module load python
export OMP_NUM_THREADS=16
export mpi_ranks=8
cd /home/hpc/pr63so/ga25cux2/roughgen
python -u ./parallel_gen.py
python -u ./start_sims.py
