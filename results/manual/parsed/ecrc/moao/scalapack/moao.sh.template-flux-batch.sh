#!/bin/bash
#FLUX: --job-name=moao
#FLUX: -t=1800
#FLUX: --urgency=16

export CRAYPE_LINK_TYPE='dynamic'
export MKL_NUM_THREADS='1 OMP_NUM_THREADS=1;'

export CRAYPE_LINK_TYPE=dynamic
module load perftools-base
export MKL_NUM_THREADS=1 OMP_NUM_THREADS=1;
srun --ntasks=32 --hint=nomultithread --ntasks-per-node=32 --ntasks-per-socket=16 ./test_moao_scalapack --nprow=4 --npcol=8 --nb=4 --filePath="/project/k1217/ltaiefh/codes/moao-dev/datafile/check/nx456_nLayers10_wfs6_Nssp10/"  --suffix="_nx456_nLayers10_wfs6_Nssp10" --maxrefine=1 --maxobs=1 --output --v
echo "== Node lists:", $SLURM_JOB_NODELIST
