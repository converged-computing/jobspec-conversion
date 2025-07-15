#!/bin/bash
#FLUX: --job-name=conspicuous-pancake-4470
#FLUX: --urgency=16

module load namd/2.10
ibrun namd2 namd.in > namd.out
