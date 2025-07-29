#!/bin/bash
#SBATCH --job-name=CortexNrdmsPySim
#SBATCH --account=proj83
#SBATCH --nodes=400
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=0
#SBATCH --time=1-00:00:00
#SBATCH --exclusive
#SBATCH --constraint=cpu

spack env activate neurodamus
module load unstable
module load neurodamus-neocortex/develop neuron/develop py-neurodamus/develop
srun dplace special -mpi -python $NEURODAMUS_PYTHON/init.py --configFile=simulation_config.json --lb-mode=RoundRobin
