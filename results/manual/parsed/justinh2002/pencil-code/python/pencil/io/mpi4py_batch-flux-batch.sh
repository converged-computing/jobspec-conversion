#!/bin/bash
#FLUX: --job-name=python-mpi
#FLUX: -n=24
#FLUX: -c=2
#FLUX: --queue=parallel
#FLUX: -t=36000
#FLUX: --urgency=16

export PATH='$USERAPPL/appl_taito/myconda3/bin:$PATH'
export PYTHONPATH='$PYTHONPATH:$PENCIL_HOME/python'

module load gcc/5.4.0
module load intelmpi/5.1.3
module load hdf5-par/1.8.18
module load python-env/3.5.3
export PATH="$USERAPPL/appl_taito/myconda3/bin:$PATH"
export PYTHONPATH="$USERAPPL/myconda3/"
export PYTHONPATH="$PYTHONPATH:$PENCIL_HOME/python"
module list
source activate $USERAPPL/myconda3
mpirun python local_fort2h5.py
