#!/bin/bash
#FLUX: --job-name=buttery-squidward-0262
#FLUX: --queue=batch
#FLUX: -t=14400
#FLUX: --urgency=16

source load_modules_qbig_kepler.sh
./test/test                                         
