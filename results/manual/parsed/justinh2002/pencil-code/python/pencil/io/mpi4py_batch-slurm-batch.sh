#!/bin/bash
#SBATCH --job-name=python-mpi
#SBATCH --output=python-mpi%J.out
#SBATCH --error=python-mpi%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=4000
#SBATCH --time=10:00:00

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
