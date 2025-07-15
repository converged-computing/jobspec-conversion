#!/bin/bash
#FLUX: --job-name=inferelator
#FLUX: -t=172800
#FLUX: --urgency=16

export RUNDIR='${SCRATCH}/inferelator/run-${SLURM_JOB_ID}/'
export DATADIR='${SCRATCH}/inferelator/data'
export PYTHONUNBUFFERED='TRUE'
export MKL_NUM_THREADS='1'
export OPENBLAS_NUM_THREADS='1'
export NUMEXPR_NUM_THREADS='1'

module purge
source ~/anaconda3/bin/activate
export RUNDIR=${SCRATCH}/inferelator/run-${SLURM_JOB_ID}/
export DATADIR=${SCRATCH}/inferelator/data
export PYTHONUNBUFFERED=TRUE
export MKL_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
echo "SLURM Environment: ${SLURM_JOB_NUM_NODES} Nodes ${SLURM_NTASKS} Tasks ${SLURM_MEM_PER_NODE} Memory/Node"
python -V
python -c "import numpy; print('NUMPY: ' + numpy.__version__)"
python -c "import pandas; print('PANDAS: ' + pandas.__version__)"
echo "Creating run directory ${RUNDIR}"
mkdir -p ${RUNDIR}
cp ${1} ${RUNDIR}
time python ${1}
