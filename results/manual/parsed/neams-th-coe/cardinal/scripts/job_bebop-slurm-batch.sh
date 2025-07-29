#!/bin/bash
#SBATCH --job-name=cardinal
#SBATCH --account=startup
#SBATCH --output=run.out
#SBATCH --error=run.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=bdwall
#SBATCH --constraint=ntasks-per-node=36

export NEKRS_HOME='$HOME_DIRECTORY_SYM_LINK/cardinal/install'
export CARDINAL_DIR='$HOME_DIRECTORY_SYM_LINK/cardinal'

module purge
module load cmake/3.20.3-vedypwm
module load gcc/9.2.0-pkmzczt
module load openmpi/4.1.1-ckyrlu7
module load python/intel-parallel-studio-cluster.2019.5-zqvneip/3.6.9
DIRECTORY_WHERE_YOU_HAVE_CARDINAL=$HOME
HOME_DIRECTORY_SYM_LINK=$(realpath -P $DIRECTORY_WHERE_YOU_HAVE_CARDINAL)
export NEKRS_HOME=$HOME_DIRECTORY_SYM_LINK/cardinal/install
export CARDINAL_DIR=$HOME_DIRECTORY_SYM_LINK/cardinal
input_file=openmc.i
srun -n 36 $CARDINAL_DIR/cardinal-opt -i $input_file > logfile
