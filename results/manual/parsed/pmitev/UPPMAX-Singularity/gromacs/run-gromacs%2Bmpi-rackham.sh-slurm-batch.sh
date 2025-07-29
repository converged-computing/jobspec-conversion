#!/bin/bash
#SBATCH --job-name=test
#SBATCH --account=staff
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=20
#SBATCH --time=00:15:00
#SBATCH --partition=devel

module load gcc/7.2.0 openmpi/2.1.1
env > env.log
scontrol show hostname $SLURM_NODELIST > host
singularity exec -B /etc/hosts.equiv -B /etc/ssh -B /etc/slurm:/etc/slurm-llnl -B /run/munge gromacs-apt.sif mpirun -n 2 -mca plm_base_verbose 10 -mca -d -display-allocation -display-map -report-uri - --hostfile host --launch-agent '/usr/bin/singularity exec /crex/proj/staff/pmitev/nobackup/RT-support/RT-gromac-singularity/gromacs-apt.sif /usr/bin/orted' /usr/bin/mdrun_mpi -ntomp 20 -s benchMEM.tpr -nsteps 10000 -resethway
