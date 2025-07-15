#!/bin/bash
#FLUX: --job-name=doopy-hobbit-1407
#FLUX: -N=8
#FLUX: -n=8
#FLUX: --queue=normal
#FLUX: -t=300
#FLUX: --priority=16

export PYTHONPATH='/users/jfavre/Projects/ParaView/Python:\$PYTHONPATH'
export PV_PLUGIN_PATH='/users/jfavre/Projects/Adamek/ParaViewLightConePlugin/build59/lib64/paraview-5.9/plugins/pvLightConeReader'

module load daint-gpu
module load PyExtensions
module load ParaView/5.9.1-CrayGNU-20.11-EGL-python3
export PYTHONPATH=/users/jfavre/Projects/ParaView/Python:\$PYTHONPATH
export PV_PLUGIN_PATH=/users/jfavre/Projects/Adamek/ParaViewLightConePlugin/build59/lib64/paraview-5.9/plugins/pvLightConeReader
srun --cpu_bind=sockets pvbatch /users/jfavre/Projects/Farbodh/pvReadSubSampler.py
