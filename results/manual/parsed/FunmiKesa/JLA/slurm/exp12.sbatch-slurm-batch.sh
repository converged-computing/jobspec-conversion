#!/bin/bash
#FLUX: --job-name=exp12
#FLUX: -c=8
#FLUX: --queue=pearl
#FLUX: -t=300
#FLUX: --urgency=16

singularity exec \
        --nv -w \
        ../../transfer sh -c "cd .. &&  sh experiments/mot17_half_jla_15_60.sh"
