#!/bin/bash
#SBATCH --job-name=sample_job
#SBATCH --account=w10001
#SBATCH --output=outlog
#SBATCH --mail-user=email@u.northwestern.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:10:00
#SBATCH --partition=w10001
#SBATCH --constraint=ntasks-per-node=4,[quest8|quest9|quest10|quest11]

module purge all
module load python-anaconda3
source activate slurm-py37-test
mpiexec -n ${SLURM_NTASKS} python -m mpi4py.bench helloworld
