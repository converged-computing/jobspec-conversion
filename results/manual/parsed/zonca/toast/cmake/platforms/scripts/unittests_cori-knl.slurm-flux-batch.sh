#!/bin/bash
#FLUX: --job-name=toastunit
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --priority=16

export OMP_NUM_THREADS='${NODE_THREAD}'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

NODES=1
NODE_PROC=32
NPROC=$(( NODES * NODE_PROC ))
NODE_CPU_PER_CORE=4
NODE_CORE=64
NODE_THREAD=$(( NODE_CORE / NODE_PROC ))
NODE_DEPTH=$(( NODE_CPU_PER_CORE * NODE_THREAD ))
export OMP_NUM_THREADS=${NODE_THREAD}
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
run="srun -n ${NPROC} -N ${NODES} -c ${NODE_DEPTH} --cpu_bind=cores"
com="python -c \"import toast; toast.test()\""
echo "${run} ${com}"
eval "${run} ${com}"
