#!/bin/bash
#FLUX --job-name=grated-arm-8604
#FLUX --queue=serial_requeue
#FLUX -t=900
#FLUX --urgency=16

module load julia/1.1.1-fasrc01
chmod u+x ./hello.jl
./hello.jl
