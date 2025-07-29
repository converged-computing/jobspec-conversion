#!/bin/bash
#SBATCH --job-name=tg
#SBATCH --account=naiss2023-1-37
#SBATCH --output=slurm2.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=shared
#SBATCH --constraint=ntasks-per-node=32

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
ml PDC
ml gromacs
rm \#* core
for conc in 0.02;do
srun gmx_mpi mdrun -s npt_${conc}.tpr -cpi npt_${conc}.cpt -deffnm npt_${conc} -v #-nsteps 130000
done
rm \#*
