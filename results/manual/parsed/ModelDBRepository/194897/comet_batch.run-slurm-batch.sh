#!/bin/bash
#SBATCH --job-name=m1ms_evol_islands
#SBATCH --account=csd403
#SBATCH --output=stdout.%j.%N.txt
#SBATCH --error=stderr.%j.%N.txt
#SBATCH --mail-user=salvadordura@gmail.com
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=6

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
