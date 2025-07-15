#!/bin/bash
#FLUX: --job-name=ipcluster
#FLUX: -N=2
#FLUX: -t=1200
#FLUX: --priority=16

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
srun ipengine --profile=${profile} --location=$(hostname) 2> /dev/null 1>&2 &
ipnport=$(shuf -i8000-9999 -n1)
XDG_RUNTIME_DIR=""
echo "${hostname}:${ipnport}" > jupyter-notebook-port-and-host
jupyter-notebook --no-browser --port=${ipnport} --ip=$(hostname -i)
