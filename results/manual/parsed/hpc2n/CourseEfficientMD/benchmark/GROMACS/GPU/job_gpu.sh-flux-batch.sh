#!/bin/bash
#FLUX: --job-name=stanky-avocado-5164
#FLUX: -n=4
#FLUX: -c=7
#FLUX: --exclusive
#FLUX: -t=1200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export reset_counters='-resetstep 10000 -nsteps 20000'

ml purge  > /dev/null 2>&1 
ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4
ml GROMACS/2021-Python-3.7.4
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export reset_counters="-resetstep 10000 -nsteps 20000"
gmx grompp -f step4.1_equilibration.mdp -o step4.1_equilibration.tpr -c step4.0_minimization.gro -r step3_charmm2gmx.pdb -n index.ndx -p topol.top
gmx mdrun -ntomp $SLURM_CPUS_PER_TASK -ntmpi $SLURM_NTASKS $reset_counters -dlb yes  -v -deffnm step4.1_equilibration
gmx mdrun -nb gpu -pme gpu -npme 1 -ntomp $SLURM_CPUS_PER_TASK -ntmpi $SLURM_NTASKS $reset_counters -dlb yes  -v -deffnm step4.1_equilibration
srun gmx_mpi mdrun -ntomp $SLURM_CPUS_PER_TASK $reset_counters -dlb yes  -v -deffnm step4.1_equilibration
srun gmx_mpi mdrun -nb gpu -pme gpu -npme 1 -ntomp $SLURM_CPUS_PER_TASK  $reset_counters -dlb yes  -v -deffnm step4.1_equilibration
