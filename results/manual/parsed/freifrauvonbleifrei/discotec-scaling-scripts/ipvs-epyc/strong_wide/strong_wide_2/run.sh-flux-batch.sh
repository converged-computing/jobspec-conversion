#!/bin/bash
#FLUX: --job-name=goodbye-fudge-5378
#FLUX: -n=65
#FLUX: --exclusive
#FLUX: -t=9600
#FLUX: --priority=16

export LD_LIBRARY_PATH='$SGPP_DIR/lib/sgpp:$LIB_GLPK:$LIB_BOOST_DIR:$LD_LIBRARY_PATH'
export I_MPI_PIN_PROCESSOR_EXCLUDE_LIST='48-95'
export I_MPI_PIN_PROCESSOR_LIST='allcores'
export I_MPI_PIN_ORDER='compact'

SLURM_CPU_BIND=verbose
SGPP_DIR=/home/pollinta/epyc/DisCoTec/
LIB_BOOST_DIR=
LIB_GLPK=$SGPP_DIR/glpk/lib/
export LD_LIBRARY_PATH=$SGPP_DIR/lib/sgpp:$LIB_GLPK:$LIB_BOOST_DIR:$LD_LIBRARY_PATH
. /home/pollinta/epyc/spack/share/spack/setup-env.sh
spack load boost@1.74.0
paramfile="ctparam_tl_system1"
if [ $# -ge 1 ] ; then
   paramfile=$1
fi
ngroup=$(grep ngroup $paramfile | awk -F"=" '{print $2}')
nprocs=$(grep nprocs $paramfile | awk -F"=" '{print $2}')
mpiprocs=$((ngroup*nprocs+1))
export I_MPI_PIN_PROCESSOR_EXCLUDE_LIST=48-95
export I_MPI_PIN_PROCESSOR_LIST="allcores"
export I_MPI_PIN_ORDER=compact
mpiexec -n "$mpiprocs" ./combi_example $paramfile
