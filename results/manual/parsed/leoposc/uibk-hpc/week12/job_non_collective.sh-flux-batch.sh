#!/bin/bash
#FLUX: --job-name=test
#FLUX: --exclusive
#FLUX: --queue=lva
#FLUX: --urgency=16

mpirun --mca fs_ufs_lock_algorithm 1 -np 12 ./bin/saveBufferNonCollective
