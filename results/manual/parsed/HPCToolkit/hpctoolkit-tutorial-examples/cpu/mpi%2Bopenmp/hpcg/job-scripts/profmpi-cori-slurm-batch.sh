#!/bin/bash
#SBATCH --output=log.analyze-parallel.out
#SBATCH --error=log.analyze-parallel.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --qos=debug
#SBATCH --constraint=knl

BINARY=xhpcg
OUT=hpctoolkit-${BINARY}
module use /global/common/software/m3977/hpctoolkit/2021-11/modules
module load hpctoolkit/2021.11-cpu
hpcstruct ${OUT}.m
ranks=8
srun -n $ranks  --cpu-bind=cores \
    hpcprof-mpi --metric-db yes -o ${OUT}.d ${OUT}.m 
touch log.analyze-parallel.done
