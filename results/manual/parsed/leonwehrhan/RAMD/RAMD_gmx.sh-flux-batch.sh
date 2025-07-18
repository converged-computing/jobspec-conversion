#!/bin/bash
#FLUX: --job-name=frigid-parsnip-2677
#FLUX: -n=8
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

module add GROMACS/2020.5-RAMD-2.0-fosscuda-2019b;
mkdir sim${SLURM_ARRAY_TASK_ID};
cd sim${SLURM_ARRAY_TASK_ID};
sed "s/XX/${SLURM_ARRAY_TASK_ID}/"  ../MDP/md.mdp > md${SLURM_ARRAY_TASK_ID}.mdp;
gmx grompp -f md${SLURM_ARRAY_TASK_ID}.mdp -c ../umb0_start.gro -p ../topol.top -n ../index.ndx -o md${SLURM_ARRAY_TASK_ID}.tpr;
gmx mdrun -deffnm md${SLURM_ARRAY_TASK_ID};
echo 18 0 | gmx trjconv -s md${SLURM_ARRAY_TASK_ID}.tpr -f md${SLURM_ARRAY_TASK_ID}.xtc -n ../index.ndx -center -pbc mol -o md${SLURM_ARRAY_TASK_ID}_noPBC.xtc;
echo 18 1 | gmx trjconv -s md${SLURM_ARRAY_TASK_ID}.tpr -f md${SLURM_ARRAY_TASK_ID}_noPBC.xtc -n ../index.ndx -fit rot+trans -o md${SLURM_ARRAY_TASK_ID}_aligned.xtc;
rm md${SLURM_ARRAY_TASK_ID}.xtc;
rm md${SLURM_ARRAY_TASK_ID}_noPBC.xtc;
