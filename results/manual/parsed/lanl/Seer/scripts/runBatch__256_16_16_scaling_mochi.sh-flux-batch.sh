#!/bin/bash
#FLUX: --job-name=anxious-rabbit-2472
#FLUX: -N=16
#FLUX: --queue=scaling
#FLUX: --urgency=16

export MPIP='-t 10.0'
export SPACK_ROOT='$HOME/spack'

export MPIP="-t 10.0"
projectpath=/projects/insituperf/HACC_Insitu/
pythonExe=/home/pascalgrosset/spack/opt/spack/linux-centos7-ivybridge/gcc-7.3.0/python-3.7.4-sudj2bfj657htfjbjzldee6dhinrtd6e/bin/python
export SPACK_ROOT=$HOME/spack
source $SPACK_ROOT/share/spack/setup-env.sh
source $projectpath/trunk/nbody/simulation/InWrap/scripts/env_setup_darwin.sh
module list
cd $projectpath/run/
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
nodes_array=( $nodes )
node1=${nodes_array[0]}
ip=$(srun --nodes=1 --ntasks=1 -w $node1 hostname --ip-address)
echo $ip
mpirun $pythonExe $projectpath/trunk/nbody/simulation/InWrap/python-utils/createJson.py $ip $projectpath/trunk/nbody/simulation/InWrap/inputs/input-HACC.json
mpirun $pythonExe $projectpath/trunk/nbody/simulation/InWrap/python-utils/launchServer.py $projectpath/trunk/nbody/simulation/InWrap/inputs/input-HACC.json &
mpirun $projectpath/trunk/Darwin/mpi/bin/hacc_pm -n inputs/indat.params -insitu /projects/insituperf/HACC/trunk/nbody/simulation/InWrap/inputs/input-HACC.json -f /projects/insituperf/HACC/run/mpitrace
