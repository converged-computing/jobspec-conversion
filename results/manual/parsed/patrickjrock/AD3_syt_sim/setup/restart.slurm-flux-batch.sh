#!/bin/bash
#FLUX: --job-name=fugly-lentil-0158
#FLUX: --urgency=16

module load namd/2.10
ibrun namd2 restart.namd > restart.out
