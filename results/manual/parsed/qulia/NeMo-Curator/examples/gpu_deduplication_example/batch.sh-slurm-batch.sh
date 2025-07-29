#!/bin/bash
#SBATCH --job-name=nemo-data-curator:gpu-deduplication
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH: --exclusive

base_dir=`pwd` # Assumes base dir is top-level dir of repo
RUNSCRIPT=${RUNSCRIPT:-${base_dir}/examples/gpu_deduplication_example/run-minhash.sh}
LIBCUDF_CUFILE_POLICY=${LIBCUDF_CUFILE_POLICY:-OFF}
echo $RUNSCRIPT
docker_image='nvcr.io/ea-bignlp/ga-participants/nemofw-training:23.08.03'
mounts="${base_dir}:${base_dir}"
srun -l \
  --container-mounts=${mounts} \
  --container-image=${docker_image} \
    bash -c "echo ${RUNSCRIPT};echo ${LIBCUDF_CUFILE_POLICY}; LIBCUDF_CUFILE_POLICY=${LIBCUDF_CUFILE_POLICY} RUNSCRIPT=${RUNSCRIPT} bash ${base_dir}/examples/gpu_deduplication_example/run-workflow.sh"
