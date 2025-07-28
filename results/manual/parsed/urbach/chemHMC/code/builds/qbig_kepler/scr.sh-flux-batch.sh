#!/bin/bash
#FLUX: --job-name=purple-peanut-butter-0211
#FLUX: --queue=batch
#FLUX: -t=14400
#FLUX: --urgency=16

source load_modules_qbig_kepler.sh
./test/test                                         
