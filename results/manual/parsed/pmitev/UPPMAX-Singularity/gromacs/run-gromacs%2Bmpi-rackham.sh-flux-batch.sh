#!/bin/bash
#FLUX: --job-name=rainbow-caramel-2636
#FLUX: -c=20
#FLUX: --urgency=16

module load gcc/7.2.0 openmpi/2.1.1
env > env.log
scontrol show hostname $SLURM_NODELIST > host
singularity exec -B /etc/hosts.equiv -B /etc/ssh -B /etc/slurm:/etc/slurm-llnl -B /run/munge gromacs-apt.sif mpirun -n 2 -mca plm_base_verbose 10 -mca -d -display-allocation -display-map -report-uri - --hostfile host --launch-agent '/usr/bin/singularity exec /crex/proj/staff/pmitev/nobackup/RT-support/RT-gromac-singularity/gromacs-apt.sif /usr/bin/orted' /usr/bin/mdrun_mpi -ntomp 20 -s benchMEM.tpr -nsteps 10000 -resethway
