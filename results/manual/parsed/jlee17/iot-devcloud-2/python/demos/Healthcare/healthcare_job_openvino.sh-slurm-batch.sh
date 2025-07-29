#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jlee17/iot-devcloud-2/python/demos/Healthcare/healthcare_job_openvino.sh
