#!/bin/bash
#FLUX: --job-name=crunchy-cupcake-4941
#FLUX: -c=12
#FLUX: -t=604800
#FLUX: --urgency=16

export JULIA_NUM_THREADS='${SLURM_CPUS_PER_TASK:=1}'

module load julia/1.7.1
export JULIA_NUM_THREADS=${SLURM_CPUS_PER_TASK:=1}
echo $JULIA_NUM_THREADS
julia GMKI_NS.jl |& tee gmki.log
