#!/bin/bash
#FLUX: --job-name=test_wp_input_file
#FLUX: --exclusive
#FLUX: -t=45000
#FLUX: --priority=16

export OMP_NUM_THREADS='16'

export OMP_NUM_THREADS=16
cd $SLURM_SUBMIT_DIR
./waterpaths -I Tests/test_input_file_dv_file.wp
