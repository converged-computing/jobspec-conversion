#!/bin/bash
#SBATCH --account=usup
#SBATCH --nodes=8
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=1,gpu

export PYTHONPATH='/users/jfavre/Projects/ParaView/Python:\$PYTHONPATH'
export PV_PLUGIN_PATH='/users/jfavre/Projects/Adamek/ParaViewLightConePlugin/build59/lib64/paraview-5.9/plugins/pvLightConeReader'

module load daint-gpu
module load PyExtensions
module load ParaView/5.9.1-CrayGNU-20.11-EGL-python3
export PYTHONPATH=/users/jfavre/Projects/ParaView/Python:\$PYTHONPATH
export PV_PLUGIN_PATH=/users/jfavre/Projects/Adamek/ParaViewLightConePlugin/build59/lib64/paraview-5.9/plugins/pvLightConeReader
srun --cpu_bind=sockets pvbatch /users/jfavre/Projects/Farbodh/pvReadSubSampler.py
