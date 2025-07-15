#!/bin/bash
#FLUX: --job-name=nemo-data-curator:gpu-deduplication
#FLUX: -N=8
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --urgency=16

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
