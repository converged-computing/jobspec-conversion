#!/bin/bash
#FLUX --job-name=nerdy-pot-9555
#FLUX --queue=batch
#FLUX -t=14400
#FLUX --urgency=16

source load_modules_qbig_kepler.sh
./test/test                                         
