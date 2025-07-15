#!/bin/bash
#FLUX: --job-name=newInstancesSubset
#FLUX: --queue=snowy
#FLUX: -t=86400
#FLUX: --urgency=16

module load gcccore/10.2.0
module load cmake/3.18.4
module load eigen/3.3.8
cd ../cpp_code
./main newInstancesTesting ${SLURM_ARRAY_TASK_ID} 6
