#!/bin/bash
#FLUX: --job-name=fugly-cinnamonbun-1135
#FLUX: -t=600
#FLUX: --urgency=16

BINARY=xhpcg
OUT=hpctoolkit-${BINARY}
module use /global/common/software/m3977/hpctoolkit/2021-11/modules
module load hpctoolkit/2021.11-cpu
hpcstruct ${OUT}.m
ranks=8
srun -n $ranks  --cpu-bind=cores \
    hpcprof-mpi --metric-db yes -o ${OUT}.d ${OUT}.m 
touch log.analyze-parallel.done
