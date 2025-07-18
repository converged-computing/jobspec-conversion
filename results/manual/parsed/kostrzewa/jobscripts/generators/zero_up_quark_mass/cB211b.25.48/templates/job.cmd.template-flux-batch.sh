#!/bin/bash
#FLUX: --job-name=kaon_=ENS=_=NSTORE=
#FLUX: -c=3
#FLUX: --queue=pascal
#FLUX: -t=21600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='${LD_LIBRARY_PATH}:/qbigwork2/bartek/libs/bleeding_edge/pascal/quda_develop-dynamic_clover/lib'
export QUDA_RESOURCE_PATH='/qbigwork2/bartek/misc/quda_resources/pascal_9c0e0dc8e96d9beb8de56a0e58a406cb486ce300_gdr${gdr}_p2p${p2p}'

gdr=0
p2p=3
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/qbigwork2/bartek/libs/bleeding_edge/pascal/quda_develop-dynamic_clover/lib
exe=/qbigwork2/bartek/build/bleeding_edge/pascal/cvc.cpff/Release/correlators
export QUDA_RESOURCE_PATH=/qbigwork2/bartek/misc/quda_resources/pascal_9c0e0dc8e96d9beb8de56a0e58a406cb486ce300_gdr${gdr}_p2p${p2p}
if [ ! -d ${QUDA_RESOURCE_PATH} ]; then
  mkdir -p ${QUDA_RESOURCE_PATH}
fi
valgrind= #valgrind
yaml_infile=definitions.yaml
cvc_infile=cpff.input
OMP_PLACES=cores OMP_SCHEDULE=dynamic,2 OMP_PROC_BIND=close \
  QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} OMP_NUM_THREADS=3 \
  QUDA_ENABLE_GDR=${gdr} QUDA_ENABLE_P2P=${p2p} QUDA_ENABLE_TUNING=1 \
  QUDA_ENABLE_DEVICE_MEMORY_POOL=0 \
  time srun ${valgrind} ${exe} -f cpff.input 2>&1 | tee ${SLURM_JOB_NAME}.out
