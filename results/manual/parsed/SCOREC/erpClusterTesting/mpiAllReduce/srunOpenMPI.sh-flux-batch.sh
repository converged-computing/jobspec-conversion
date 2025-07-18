#!/bin/bash
#FLUX: --job-name=erpMpiTesting
#FLUX: --urgency=16

export PATH='$PATH:$ompi/bin'

p=$1
numabind=$2
module use /gpfs/u/software/erp-spack-install/lmod/linux-centos7-x86_64/Core/
module load gcc
ompi=/gpfs/u//software/erp-rhel7/openmpi/4.0.1/2/
export PATH=$PATH:$ompi/bin
osu=/gpfs/u/home/CCNI/CCNIsmth/barn-shared/CWS/osu-micro-benchmarks-5.6.1-erp-openmpi.4.0.1-verbs-noUcx-Pmi-install/
bin=$osu/libexec/osu-micro-benchmarks/mpi/
numamap=""
for nn in 4 5 6 7 0 1 2 3; do
  for core in {1..6}; do # six cores per numa domain
    if [ -z "$numamap" ]; then
      numamap=${nn}
    else
      numamap=${numamap},${nn}
    fi
  done
done
binding="default"
[ "$numabind" == "on" ] && bindopt=",map_ldom=${numamap}" && binding="numa"
echo "processes $p"
echo "nodes $SLURM_JOB_NUM_NODES"
echo "ppn $((p/SLURM_JOB_NUM_NODES))"
echo "binding ${binding}"
set -x
srun --mpi=pmi2 -n $p --cpu_bind=verbose${bindopt} $bin/collective/osu_allreduce
set +x
