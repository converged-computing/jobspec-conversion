#!/bin/bash
#FLUX: --job-name=DDMnets
#FLUX: --queue=Epyc7452
#FLUX: --urgency=16

export PYTHONPATH='/home/areina/DecisionsOnNetworks/src/'

source /home/areina/pythonVirtualEnvs/DDMonNetsEnv/bin/activate
export PYTHONPATH=/home/areina/DecisionsOnNetworks/src/
cd $PYTHONPATH
srun python3 ${1} ${2}
deactivate
