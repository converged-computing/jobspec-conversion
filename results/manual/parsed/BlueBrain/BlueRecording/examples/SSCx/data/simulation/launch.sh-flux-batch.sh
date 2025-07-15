#!/bin/bash
#FLUX: --job-name=CortexNrdmsPySim
#FLUX: -N=400
#FLUX: -c=2
#FLUX: --exclusive
#FLUX: --queue=prod
#FLUX: -t=86400
#FLUX: --urgency=16

spack env activate neurodamus
module load unstable
module load neurodamus-neocortex/develop neuron/develop py-neurodamus/develop
srun dplace special -mpi -python $NEURODAMUS_PYTHON/init.py --configFile=simulation_config.json --lb-mode=RoundRobin
