#!/bin/bash
#SBATCH --job-name=MyMPIJob
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=48

module load hpcx-mpi/4.1.5rc2s
EXAMPLE_VARIABLE="Hello!"
echo $EXAMPLE_VARIABLE
srun --mpi=pmix echo $EXAMPLE_VARIABLE 
