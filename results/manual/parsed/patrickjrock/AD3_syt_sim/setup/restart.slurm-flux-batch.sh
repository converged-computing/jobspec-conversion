#!/bin/bash
#FLUX: --job-name=tart-noodle-5174
#FLUX: --priority=16

module load namd/2.10
ibrun namd2 restart.namd > restart.out
