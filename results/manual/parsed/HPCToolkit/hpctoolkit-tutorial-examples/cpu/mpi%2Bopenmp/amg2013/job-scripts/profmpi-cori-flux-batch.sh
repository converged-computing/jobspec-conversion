#!/bin/bash
#FLUX: --job-name=fat-omelette-1376
#FLUX: -t=600
#FLUX: --priority=16

OUT=hpctoolkit-amg2013
module use /global/common/software/m3977/hpctoolkit/2021-11/modules
module load hpctoolkit/2021.11-cpu
hpcstruct ${OUT}.m
/bin/rm -rf ${OUT}.d
ranks=8
srun -n $ranks  --cpu-bind=cores \
    hpcprof-mpi --metric-db yes -o ${OUT}.d ${OUT}.m
touch log.analyze-parallel.done
