#!/bin/bash
#FLUX: --job-name=NNP-mpi
#FLUX: -n=28
#FLUX: -t=258600
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

set +e
source $MODULESHOME/init/bash    # necessary in the case of zsh or other init shells
module load intel intel-mpi intel-mkl gsl eigen 
export OMP_NUM_THREADS=1
srun -n 21 /home/glensk/Dropbox/Albert/git/n2p2/bin/nnp-train
exit 0
