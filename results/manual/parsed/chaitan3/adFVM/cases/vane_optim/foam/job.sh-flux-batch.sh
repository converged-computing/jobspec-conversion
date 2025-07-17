#!/bin/bash
#FLUX: --job-name=rainbow-truffle-6288
#FLUX: -N=16
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$HOME/sources/petsc/arch-linux2-c-opt/lib'
export PYTHONPATH='$HOME/.local/lib/python.7/site-packages/:$PYTHONPATH'

set -e
source /etc/profile.d/master-bin.sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/sources/petsc/arch-linux2-c-opt/lib
export PYTHONPATH=$HOME/.local/lib/python.7/site-packages/:$PYTHONPATH
mpirun ~/adFVM/apps/problem.py ./vane_optim_adj.py > primal_output.log 2>primal_error.log
for i in `seq 0 39`; do
	mpirun ~/adFVM/apps/adjoint.py ./vane_optim_adj.py >> adjoint_output.log 2>>adjoint_error.log
done
