#!/bin/bash
#FLUX: --job-name=Gromacs
#FLUX: -n=4
#FLUX: -c=7
#FLUX: --exclusive
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    mdargs="-ntomp $SLURM_CPUS_PER_TASK"
else
    mdargs="-ntomp 1"
fi
nvidia-smi
echo $CUDA_VISIBLE_DEVICES 
ml purge > /dev/null 2>&1
ml GCC/10.2.0  CUDA/11.1.1  OpenMPI/4.0.5
ml GROMACS/2021
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
gmx grompp -f step4.1_equilibration.mdp -o step4.1_equilibration.tpr -c step4.0_minimization.gro -r step3_charmm2gmx.pdb -n index.ndx -p topol.top
sleep 10
mpirun -np $SLURM_NTASKS gmx_mpi mdrun $mdargs -dlb yes  -v -deffnm step4.1_equilibration
sleep 10
mpirun -np $SLURM_NTASKS gmx_mpi mdrun -nb gpu -pme gpu -npme 1 $mdargs -dlb yes  -v -deffnm step4.1_equilibration
sleep 10
gmx mdrun -ntmpi $SLURM_NTASKS -nb gpu -pme gpu -npme 1 $mdargs -dlb yes  -v -deffnm step4.1_equilibration
