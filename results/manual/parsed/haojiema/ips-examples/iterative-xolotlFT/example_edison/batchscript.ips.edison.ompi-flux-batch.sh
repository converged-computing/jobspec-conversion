#!/bin/bash
#FLUX: --job-name=salted-butter-3354
#FLUX: -N=2
#FLUX: --queue=regular
#FLUX: -t=43200
#FLUX: --urgency=16

export OMPI_ROOT='/project/projectdirs/atom/users/elwasif/ompi/install_4.0'
export PATH='$OMPI_ROOT/bin:$PATH'
export LD_LIBRARY_PATH='$OMPI_ROOT/lib64:$OMPI_ROOT/lib:$LD_LIBRARY_PATH'
export MANPATH='$OMPI_ROOT/share/man:$MANPATH'

cd $SLURM_SUBMIT_DIR   # optional, since this is the default behavior
source /project/projectdirs/atom/users/$USER/ips-wrappers/env.ips.edison
module swap PrgEnv-intel PrgEnv-gnu
export OMPI_ROOT=/project/projectdirs/atom/users/elwasif/ompi/install_4.0
export PATH=$OMPI_ROOT/bin:$PATH
export LD_LIBRARY_PATH=$OMPI_ROOT/lib64:$OMPI_ROOT/lib:$LD_LIBRARY_PATH
export MANPATH=$OMPI_ROOT/share/man:$MANPATH
srun -n $SLURM_NNODES --ntasks-per-node=1 hostname > .node_names.$$
for n in $(cat .node_names.$$); do echo "$n slots=24" >> .hostfile.$$ ; done
orte-dvm --hostfile ./.hostfile.$$ &
sleep 5
$IPS_PATH/bin/ips.py --config=ftx.config --platform=conf.ips.edison.ompi --log=log.framework 2>>log.stdErr 1>>log.stdOut
egrep -i 'error' log.* > log.errors
./setPermissions.sh
