#!/bin/bash
#FLUX: --job-name=expressive-motorcycle-2173
#FLUX: -N=2
#FLUX: -t=900
#FLUX: --priority=16

export PMIX_MCA_gds='^ds12'
export OMPI_MCA_btl_vader_single_copy_mechanism='none'

module purge
module load StdEnv/2020 gcc/9.3.0 openmpi/4.0.3 apptainer
CACHE_DIR="${SLURM_TMPDIR}/.cache"
srun --ntasks-per-node=1 mkdir -p $CACHE_DIR
APPTAINER_OPTS="\
  --bind="${SLURM_TMPDIR}:/tmp,${CACHE_DIR}:/fd/.cache" \
  --home $PWD \
"
export PMIX_MCA_gds="^ds12"
export OMPI_MCA_btl_vader_single_copy_mechanism="none"
for CONTAINER in openmpi-hybrid.sif openmpi-hybrid-slurm.sif ; do
  for MPIRUN in mpirun mpiexec "srun --mpi=pmi2" ; do
    for TEST in /opt/mpitest /opt/mpitest_sendrecv "/opt/reduce_stddev 100000000" ; do
      echo "running:"
      echo "  ${MPIRUN} apptainer --silent exec \\"
      echo "    ${APPTAINER_OPTS} \\"
      echo "    ${CONTAINER} $TEST"
      echo ""
      echo "========================================="
      echo ""
      time  ${MPIRUN}  apptainer --silent exec \
            ${APPTAINER_OPTS} \
            ${CONTAINER}  $TEST
      echo ""
      echo "========================================="
      echo ""
    done
  done
done
