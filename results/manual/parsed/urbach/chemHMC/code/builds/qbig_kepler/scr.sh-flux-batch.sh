#!/bin/bash
#FLUX: --job-name=persnickety-leader-9121
#FLUX: --queue=batch
#FLUX: -t=14400
#FLUX: --priority=16

source load_modules_qbig_kepler.sh
./test/test                                         
