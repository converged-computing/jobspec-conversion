#!/bin/bash
#FLUX: --job-name=exp3
#FLUX: -c=8
#FLUX: --urgency=16

singularity exec \
        --nv -w \
        ../../transfer sh -c "cd .. &&  sh experiments/mot17_half_ft_ch_jla_10_60_128.sh"
