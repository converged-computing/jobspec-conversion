#!/bin/bash
#FLUX: --job-name=compile_Enzo
#FLUX: -t=1800
#FLUX: --urgency=16

pwd; hostname; date
module add cuda
moudle add cudnn
./make-rusty.sh
date
