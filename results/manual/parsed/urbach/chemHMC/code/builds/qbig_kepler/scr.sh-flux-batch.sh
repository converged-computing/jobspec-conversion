#!/bin/bash
#FLUX --job-name=persnickety-pot-7488
#FLUX --queue=batch
#FLUX -t=14400
#FLUX --urgency=16

source load_modules_qbig_kepler.sh
./test/test                                         
