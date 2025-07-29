#!/bin/bash
#SBATCH --job-name=tax5_400_450
#SBATCH --account=bevanlab
#SBATCH --mail-user=kelsieking23@vt.edu
#SBATCH --mail-type=all
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=6-00:00:00
#SBATCH --constraint=ntasks-per-node=24

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/groups/bevanlab/software/cascades/fftw/3.3.8/lib:/home/kelsieking23/software/gromacs/4.6.5/bin'

module load intel
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/groups/bevanlab/software/cascades/fftw/3.3.8/lib:/home/kelsieking23/software/gromacs/4.6.5/bin
source /home/kelsieking23/software/gromacs/4.6.5/bin/GMXRC
