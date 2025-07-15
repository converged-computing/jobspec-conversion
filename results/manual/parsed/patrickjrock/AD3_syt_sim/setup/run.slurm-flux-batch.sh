#!/bin/bash
#FLUX: --job-name=loopy-pot-7463
#FLUX: --priority=16

module load namd/2.10
ibrun namd2 namd.in > namd.out
