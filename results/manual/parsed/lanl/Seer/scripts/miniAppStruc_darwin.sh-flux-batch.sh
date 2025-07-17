#!/bin/bash
#FLUX: --job-name=expressive-caramel-2459
#FLUX: -N=2
#FLUX: --queue=galton
#FLUX: --urgency=16

export MPIP='-t 10.0'
export SPACK_ROOT='$HOME/spack'

export MPIP="-t 10.0"
projectpath=/projects/insituperf/Seer
export SPACK_ROOT=$HOME/spack
source $SPACK_ROOT/share/spack/setup-env.sh
source $projectpath/evn/env_darwin_sim.sh
module list
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
nodes_array=( $nodes )
node1=${nodes_array[0]}
ip=$(srun --nodes=1 --ntasks=1 -w $node1 hostname --ip-address)
echo $ip
cd $projectpath/buildII
mkdir logs
mpirun python $projectpath/Seer_Mochi/createJsonConfig.py $ip $projectpath/inputs/input-test-structured.json
echo "create Json done"
mpirun python $projectpath/Seer_Mochi/launchMochiServer.py $projectpath/inputs/input-test-structured.json &
mpirun $projectpath/buildII/demoApps/miniAppStructured --insitu $projectpath/inputs/input-test-structured.json
