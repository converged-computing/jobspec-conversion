#!/bin/bash
#FLUX: --job-name=mlreco_p100
#FLUX: --queue=gpu,ccgpu,wongjiradlab
#FLUX: -t=518400
#FLUX: --priority=16

WORKDIR=/cluster/tufts/wongjiradlabnu/twongj01/mlreco/lartpc_mlreco3d/
container=/cluster/tufts/wongjiradlabnu/larbys/larbys-container/singularity_minkowskiengine_u20.04.cu111.torch1.9.0_comput8.sif
module load singularity/3.5.3
singularity exec --nv --bind /cluster/tufts/:/cluster/tufts/,/tmp:/tmp $container bash -c "source ${WORKDIR}/run_ubmlreco_uresnet_ppn.sh"
