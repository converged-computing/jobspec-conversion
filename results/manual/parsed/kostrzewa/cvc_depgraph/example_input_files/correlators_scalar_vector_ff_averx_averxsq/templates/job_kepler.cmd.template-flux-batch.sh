#!/bin/bash
#FLUX: --job-name=correlators_cA211a.30.32_cov_displ__NSTORE_
#FLUX: -N=2
#FLUX: -c=2
#FLUX: --queue=kepler
#FLUX: -t=86400
#FLUX: --priority=16

export LD_LIBRARY_PATH='${LD_LIBRARY_PATH}:/qbigwork2/bartek/libs/bleeding_edge/kepler/quda_develop-dynamic_clover/lib'
export QUDA_RESOURCE_PATH='/qbigwork2/bartek/misc/quda_resources/kepler_9c0e0dc8e96d9beb8de56a0e58a406cb486ce300_gdr${gdr}_p2p${p2p}'

gdr=0
p2p=3
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/qbigwork2/bartek/libs/bleeding_edge/kepler/quda_develop-dynamic_clover/lib
exe=/qbigwork2/bartek/build/bleeding_edge/kepler/cvc.cpff/correlators
export QUDA_RESOURCE_PATH=/qbigwork2/bartek/misc/quda_resources/kepler_9c0e0dc8e96d9beb8de56a0e58a406cb486ce300_gdr${gdr}_p2p${p2p}
if [ ! -d ${QUDA_RESOURCE_PATH} ]; then
  mkdir -p ${QUDA_RESOURCE_PATH}
fi
valgrind= #valgrind
yaml_infile=definitions.yaml
cvc_infile=cpff.input
QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} OMP_NUM_THREADS=2 \
  QUDA_ENABLE_GDR=${gdr} QUDA_ENABLE_P2P=${p2p} QUDA_ENABLE_TUNING=1 \
  QUDA_ENABLE_DEVICE_MEMORY_POOL=0 \
  time srun ${valgrind} ${exe} -f cpff.input 2>&1 | tee ${SLURM_JOB_NAME}.out
