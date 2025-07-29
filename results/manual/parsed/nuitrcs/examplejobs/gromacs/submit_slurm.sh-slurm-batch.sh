#!/bin/bash
#SBATCH --job-name=sample_job
#SBATCH --account=pXXXX
#SBATCH --output=outlog_gromacs
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3G
#SBATCH --time=00:20:00
#SBATCH --constraint=ntasks-per-node=8,[quest8|quest9|quest10|quest11]

export OMP_NUM_THREADS='1'
export GMX_MAXBACKUP='-1'
export jobname='1us-apo-NMDA-4PE5_v1'

module purge
module load gromacs/2020.4-openmpi-4.0.5-gcc-10.2.0
export OMP_NUM_THREADS=1
export GMX_MAXBACKUP=-1
export jobname="1us-apo-NMDA-4PE5_v1"
mpirun -np ${SLURM_NTASKS} gmx_mpi mdrun -s ${jobname}.tpr -cpi ${jobname}.cpt -deffnm ${jobname} -maxh 2 -noappend
