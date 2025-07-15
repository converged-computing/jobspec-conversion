#!/bin/bash
#FLUX: --job-name=borg_input_file
#FLUX: --exclusive
#FLUX: -t=504000
#FLUX: --priority=16

export OMP_NUM_THREADS='5'

export OMP_NUM_THREADS=5
cd $SLURM_SUBMIT_DIR
module load valgrind/3.15.0
mpirun -np 48 ./waterpaths -I Tests/test_input_file_borg.wp
