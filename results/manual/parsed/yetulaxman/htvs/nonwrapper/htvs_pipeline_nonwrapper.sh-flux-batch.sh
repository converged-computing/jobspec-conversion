#!/bin/bash
#FLUX: --job-name=anxious-taco-1393
#FLUX: -n=4
#FLUX: --queue=small
#FLUX: -t=4210
#FLUX: --urgency=16

module load maestro parallel
"$SCHRODINGER/pipeline" -prog mydb phase_inputWnjC.inp -OVERWRITE -HOST localhost:4 -NJOBS 4 -WAIT
