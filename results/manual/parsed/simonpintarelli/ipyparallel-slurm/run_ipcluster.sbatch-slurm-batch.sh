#!/bin/bash
#FLUX: --job-name=ipcluster
#FLUX: -t=1200
#FLUX: --urgency=16

module load daint-gpu
module load cray-python/3.6.5.1
module load EasyBuild-custom/cscs
module load PyExtensions
module load jupyter
profile=job_${SLURM_JOB_ID}
echo "creating profile: ${profile}"
ipython profile create ${profile}
echo "Launching controller"
ipcontroller --ip="*" --profile=${profile} &
sleep 10
echo "Launching engines"
srun ipengine --profile=${profile} --location=$(hostname)
