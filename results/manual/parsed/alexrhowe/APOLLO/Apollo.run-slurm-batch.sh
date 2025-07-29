#!/bin/bash
#SBATCH --job-name=Apollo
#SBATCH --account=your_account
#SBATCH --mail-user=your_email
#SBATCH --mail-type=ALL
#SBATCH --nodes=8
#SBATCH --ntasks=216
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000m
#SBATCH --time=16:00:00
#SBATCH --qos=long
#SBATCH --constraint=hasw

export PYTHONPATH='/usr/local/other/MPI4PY/PYTHON3/lib/python3.7/site-packages/'

if [ -n "$SLURM_SUBMIT_DIR" ]; then cd $SLURM_SUBMIT_DIR; fi
ulimit -v unlimited
ulimit -s unlimited
source /usr/share/modules/init/bash
module purge
module load python/GEOSpyD/Ana2019.10_py3.7
module load comp/gcc/9.2.0
module load mpi/impi/19.0.4.243
export PYTHONPATH=/usr/local/other/MPI4PY/PYTHON3/lib/python3.7/site-packages/
mpirun -np 216 python Apollo.py examples/example.resolved.dat Retrieval > /discover/nobackup/arhowe1/Apollo.log
