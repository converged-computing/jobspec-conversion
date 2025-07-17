#!/bin/bash
#FLUX: --job-name=carnivorous-hope-3452
#FLUX: --queue=batch
#FLUX: -t=14400
#FLUX: --urgency=16

source load_modules_qbig_kepler.sh
./test/test                                         
