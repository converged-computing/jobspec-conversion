#!/bin/bash
#FLUX: --job-name=replica-exchange
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load gromacs/openmpi/intel/2018.3
srun --pty /bin/bash 
mpirun -np 3 gmx_mpi mdrun -s adp -multidir T300/ T363 T440/ -deffnm adp_exchange3temps -replex 50
