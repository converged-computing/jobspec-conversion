#!/bin/bash
#FLUX: --job-name=gtrain
#FLUX: -c=8
#FLUX: -t=115200
#FLUX: --urgency=16

echo "$(date)"
module purge
singularity exec --nv --overlay /scratch/cg3306/climate/subgrid/gz21/overlay-15GB-500K.ext3:ro\
	 /scratch/work/public/singularity/cuda10.1-cudnn7-devel-ubuntu18.04.sif /bin/bash -c "
		source /ext3/env.sh;
		mlflow run -e global-train . --env-manager local --experiment-name gtrain --run-name full;
	"
echo "$(date)"
