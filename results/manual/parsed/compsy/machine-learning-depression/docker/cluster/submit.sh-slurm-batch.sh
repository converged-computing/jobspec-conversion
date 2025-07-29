#!/bin/bash
#SBATCH --job-name=python_cpu
#SBATCH --mail-user=peregrine@compsy.nl
#SBATCH --mail-type=ALL
#SBATCH --nodes=30
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=23
#SBATCH --mem=8000
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

export MPLBACKEND='agg'
export OMP_NUM_THREADS='23'

module load Python/3.5.1-foss-2016a
module load R/3.3.1-foss-2016a
module load OpenMPI/1.10.2-GCC-4.9.3-2.25
gitdir="ICPE_machine_learning_workgroup"
cd $gitdir
echo "Running main.py"
export MPLBACKEND="agg"
export OMP_NUM_THREADS=23
srun python3 main.py -c -n -f
echo "Finished main.py"
