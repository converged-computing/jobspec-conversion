#!/bin/bash
#FLUX: --job-name=chocolate-leader-6172
#FLUX: -N=8
#FLUX: -n=320
#FLUX: -t=1800
#FLUX: --urgency=16

run() {
  local hostfile=$1
  local processes=$2
  local exeModules=$3
  local exeEnvVars=$4
  local exe=$5
  local outfile=$6
  local baseModules="gcc/7.4.0/1 openmpi/3.1.4-mm5hjuq"
  module load ${baseModules}
  module load ${exeModules}
  set -x
  mpirun -wdir $PWD --prefix ${OPENMPI_ROOT} --bind-to core \
    -hostfile ${hostfile} \
    -n ${processes} \
    -x LD_LIBRARY_PATH \
    $exeEnvVars \
    ${exe} &> ${outfile} &
  set +x
  module purge
}
echo $(date)
[ ! -d coupling ] && mkdir coupling
rm coupling/*
nodes=($(srun hostname -s | sort -u))
n_nodes_XGC=7
n_mpi_ranks_XGC=256
cd XGC/
mkdir -p restart_dir
OUTFILE=xgc1_${SLURM_JOB_ID}.out
XGC_EXEC=/path/to/xgc-es
for((i=0;i<n_nodes_XGC;i++)); do
  echo ${nodes[i]} >> /tmp/xgchosts.$SLURM_JOB_ID
done
xgcEnvVars="-x OMP_NUM_THREADS=1 \
  -x OMP_PLACES=threads \
  -x OMP_PROC_BIND=spread \
  -x OMP_MAX_ACTIVE_LEVELS=2 \
  -x OMP_NESTED=TRUE \
  -x OMP_STACKSIZE=2G"
xgcModules="adios/1.13.1-ev2p4am \
  adios2/2.5.0-mklg6ph \
  petsc/3.7.7-int32-hdf5+ftn-real-c-7ewou4w \
  fftw/3.3.8-b2oxdb5 \
  pkg-config/system-cyeqmxc"
run /tmp/xgchosts.$SLURM_JOB_ID ${n_mpi_ranks_XGC} ${xgcModules} "${xgcEnvVars}" ${XGC_EXEC} ${OUTFILE}
n_nodes_GENE=1
n_mpi_ranks_GENE=16
cd ../GENE
mkdir -p out
OUTFILE=GENE_${SLURM_JOB_ID}.out
GENE_EXEC=/path/to/gene
for((i=n_nodes_XGC+n_nodes_CPL;i<(n_nodes_XGC+n_nodes_GENE);i++)); do
  echo ${nodes[i]} >> /tmp/genehosts.$SLURM_JOB_ID
done
geneEnvVars="-x HDF5_USE_FILE_LOCKING=FALSE -x OMP_NUM_THREADS=1"
geneModules="adios/1.13.1-zrrxpbi \
  adios2/2.5.0-rqsvxj4 \
  fftw/3.3.8-b2oxdb5 \
  netlib-scalapack/2.0.2-7bndnga \
  openblas/0.3.7-x7m3b6w \
  zlib/1.2.11-lpgvqh7 \
  hdf5/1.10.3-ftn-tgragps"
run /tmp/genehosts.$SLURM_JOB_ID ${n_mpi_ranks_GENE} ${geneModules} "${geneEnvVars}" ${GENE_EXEC} ${OUTFILE}
wait
echo $(date)
