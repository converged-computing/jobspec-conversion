#!/bin/bash
#FLUX: --job-name=scruptious-egg-1916
#FLUX: -c=6
#FLUX: -t=518400
#FLUX: --urgency=16

export OMP_NUM_THREADS='${​​​​SLURM_CPUS_PER_TASK}'

echo ${SLURM_ARRAY_TASK_ID}
source /etc/profile.d/modules.sh
module purge
module load apps/gromacs/2020.3-AVX2
export OMP_NUM_THREADS=${​​​​SLURM_CPUS_PER_TASK}
echo ${SLURM_CPUS_PER_TASK}
mkdir EQUIL
mkdir PROD
for i in $((${SLURM_ARRAY_TASK_ID}))  # {-49..-46} $((-${SLURM_ARRAY_TASK_ID}))
do
   echo $i
   #gmx grompp -f MDP/MIN.mdp -c bio_ions.gro -r bio_ions.gro -p topol.top -n index.ndx -o EQUIL/min.tpr
   #cd EQUIL
   #gmx mdrun -v -deffnm min
   #cd ..
   ### NVT k=500 ###
   gmx grompp -f MDP/NVT_$i.mdp -c equil.gro -r bio_ace_KCl.gro -p topol.top -n index_system.ndx -o EQUIL/nvt_$i.tpr
   cd EQUIL
   gmx mdrun -v -deffnm nvt_$i -ntomp ${SLURM_CPUS_PER_TASK} #-update gpu
   cd ..
   ### 100ps NPT k=1000 ###
   gmx grompp -f MDP/NPT_$i.mdp -c EQUIL/nvt_$i.gro -r bio_ace_KCl.gro -t EQUIL/nvt_$i.cpt -p topol.top -n index_system.ndx -o EQUIL/npt_$i.tpr
   cd EQUIL
   gmx mdrun -v -deffnm npt_$i -ntomp ${SLURM_CPUS_PER_TASK} #-update gpu
   cd ..
   ### 25 ns k=500 ###
   gmx grompp -f MDP/PROD_$i.mdp -c EQUIL/npt_$i.gro -r bio_ace_KCl.gro -t EQUIL/npt_$i.cpt -p topol.top -n index_system.ndx -o PROD/prod_$i.tpr
   cd PROD
   gmx mdrun -v -deffnm prod_$i -ntomp ${SLURM_CPUS_PER_TASK} #-update gpu
   cd ..
   #gmx grompp -f MDP/higher_$i.mdp -c EQUIL/npt_$j.gro -r bio_ace_KCl.gro -t EQUIL/npt_$j.cpt -p topol.top -n index_system.ndx -o PROD/higher_$i.tpr
   cd PROD
   #gmx mdrun -v -deffnm higher_$i -ntomp ${SLURM_CPUS_PER_TASK} #-update gpu
done
