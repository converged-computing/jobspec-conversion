#!/bin/bash
#FLUX: --job-name=twopt_funs_cA211a.30.32__NSTORE_
#FLUX: -N=2
#FLUX: -c=2
#FLUX: --queue=kepler
#FLUX: -t=86400
#FLUX: --priority=16

export QUDA_RESOURCE_PATH='/qbigwork2/bartek/misc/quda_resources/kepler_v0.9.0-724-g405d5bf1-dynamic_clover_gdr${gdr}_p2p${p2p}'

gdr=0
p2p=3
exe=/qbigwork2/bartek/build/bleeding_edge/kepler/cvc.cpff/correlators
export QUDA_RESOURCE_PATH=/qbigwork2/bartek/misc/quda_resources/kepler_v0.9.0-724-g405d5bf1-dynamic_clover_gdr${gdr}_p2p${p2p}
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
