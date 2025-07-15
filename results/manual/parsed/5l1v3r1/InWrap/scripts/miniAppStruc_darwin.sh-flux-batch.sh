#!/bin/bash
#FLUX: --job-name=persnickety-avocado-9638
#FLUX: --urgency=16

export MPIP='-t 10.0'
export SPACK_ROOT='$HOME/spack'

export MPIP="-t 10.0"
projectpath=/projects/insituperf/InWrap
pythonExe=/home/pascalgrosset/miniconda3/bin/python
export SPACK_ROOT=$HOME/spack
source $SPACK_ROOT/share/spack/setup-env.sh
source $projectpath/InWrap/scripts/env_setup_darwin.sh
module list
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
nodes_array=( $nodes )
node1=${nodes_array[0]}
ip=$(srun --nodes=1 --ntasks=1 -w $node1 hostname --ip-address)
echo $ip
cd $projectpath/build
mkdir logs
mpirun $projectpath/build/demoApps/miniAppStructured --insitu $projectpath/inputs/input-test-structured.json
