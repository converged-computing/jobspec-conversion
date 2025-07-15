#!/bin/bash
#FLUX: --job-name=psycho-egg-8864
#FLUX: --queue=compute
#FLUX: --urgency=16

export MODULEPATH='/share/apps/compute/modulefiles/mpi:$MODULEPATH'
export PATH='~nsguser/applications/neuron7.4/installdir/x86_64/bin:~nsguser/.local/bin:$PATH'
export LD_LIBRARY_PATH='~nsguser/applications/neuron7.4/installdir/x86_64/lib:$LD_LIBRARY_PATH'

module purge
module load intel
export MODULEPATH=/share/apps/compute/modulefiles/mpi:$MODULEPATH
module load openmpi_ib/1.8.4npmi
module load python
module load gsl
module load scipy
module load gnu
module load mkl
export PATH=~nsguser/applications/neuron7.4/installdir/x86_64/bin:~nsguser/.local/bin:$PATH
export LD_LIBRARY_PATH=~nsguser/applications/neuron7.4/installdir/x86_64/lib:$LD_LIBRARY_PATH
cd '/home/salvadord/m1ms/sim/'
python evol_islands.py 
