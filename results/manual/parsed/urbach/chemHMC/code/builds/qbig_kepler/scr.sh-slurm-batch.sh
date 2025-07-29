#!/bin/bash
#FLUX: --job-name=arid-carrot-1357
#FLUX: --queue=batch
#FLUX: -t=14400
#FLUX: --urgency=16

source load_modules_qbig_kepler.sh
./test/test                                         
