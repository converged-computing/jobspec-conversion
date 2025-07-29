#!/bin/bash
#SBATCH --job-name=replica-exchange
#SBATCH --mail-user=tje3676@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=3

module purge
module load gromacs/openmpi/intel/2018.3
srun --pty /bin/bash 
mpirun -np 3 gmx_mpi mdrun -s adp -multidir T300/ T363 T440/ -deffnm adp_exchange3temps -replex 50
