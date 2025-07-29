#!/bin/bash
#SBATCH --output=result_%j.out
#SBATCH --error=error_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

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
