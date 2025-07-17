#!/bin/bash
#FLUX: --job-name=hairy-malarkey-5145
#FLUX: -t=86400
#FLUX: --urgency=16

source $HOME/.load_modules.sh
source $HOME/dune/venv/bin/activate
mpirun -N 1 python -c "import sys; print(sys.version); import dune"
cd $SNIC_TMP
mpirun -N 1 cp -r $HOME/dune-course/ .
cd dune-course
echo "STARTING"
mpirun python $@
echo "FINISHED"
ls
destination=$HOME/vtu/$SLURM_JOB_ID
mkdir -p $destination && cp -pr *vtu $destination
destination=$HOME/info/$SLURM_JOB_ID
mkdir -p $destination && cp *.json $destination
