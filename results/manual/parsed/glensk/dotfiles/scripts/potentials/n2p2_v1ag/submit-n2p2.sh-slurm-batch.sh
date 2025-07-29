#!/bin/bash
#SBATCH --job-name=NNP-mpi
#SBATCH --output=_scheduler-stdout.txt
#SBATCH --error=_scheduler-stderr.txt
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --time=2-23:50:00
#SBATCH --constraint=E5v4

export OMP_NUM_THREADS='1'

set +e
source $MODULESHOME/init/bash    # necessary in the case of zsh or other init shells
module load intel intel-mpi intel-mkl gsl eigen 
export OMP_NUM_THREADS=1
srun -n 21 /home/glensk/Dropbox/Albert/git/n2p2/bin/nnp-train
exit 0
