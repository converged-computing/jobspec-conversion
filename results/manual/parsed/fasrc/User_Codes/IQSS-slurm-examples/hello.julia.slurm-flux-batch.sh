#!/bin/bash
#FLUX: --job-name=chocolate-poodle-5980
#FLUX: --queue=serial_requeue
#FLUX: -t=900
#FLUX: --urgency=16

module load julia/1.1.1-fasrc01
chmod u+x ./hello.jl
./hello.jl
