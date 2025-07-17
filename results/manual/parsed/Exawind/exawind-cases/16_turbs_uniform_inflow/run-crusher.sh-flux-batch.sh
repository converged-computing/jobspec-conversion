#!/bin/bash
#FLUX: --job-name=16-turbine-crusher
#FLUX: -N=96
#FLUX: -t=1800
#FLUX: --urgency=16

set -e
cmd() {
  echo "+ $@"
  eval "$@"
}
cmd "export SPACK_MANAGER=${WORLDWORK}/cfd116/software/spack-manager-crusher"
cmd "source ${SPACK_MANAGER}/start.sh && spack-start"
cmd "spack env activate -d ${SPACK_MANAGER}/environments/exawind-crusher"
cmd "spack load exawind+amr_wind_gpu+nalu_wind_gpu"
cmd "spack load trilinos+rocm"
cmd "module load rocm/5.4.0"
cmd "which exawind"
cmd "rm -rf mesh"
cmd "mkdir mesh"
cmd "export FI_CXI_RX_MATCH_MODE=software"
cmd "srun -N1 -n16 -c1 stk_balance.exe -o ./mesh/ -i ./nrel5mw_nearbody.exo"
cmd "srun -N96 -n768 --gpus-per-node=8 --gpu-bind=closest exawind --awind 512 --nwind 256 nrel5mw.yaml"
cmd "rm -r mesh"
