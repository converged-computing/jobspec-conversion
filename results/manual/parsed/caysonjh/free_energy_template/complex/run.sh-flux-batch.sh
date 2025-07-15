#!/bin/bash
#FLUX: --job-name=reclusive-train-0887
#FLUX: -n=24
#FLUX: -t=43200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'
export COMPLEX='1RST_sol'
export TASK_ID='$(printf "%02d" $SLURM_ARRAY_TASK_ID)'

module purge
module load cuda/11.4 gromacs/2021.4
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
export COMPLEX=1RST_sol
export TASK_ID=$(printf "%02d" $SLURM_ARRAY_TASK_ID)
mkdir lambda.${TASK_ID}
cd lambda.${TASK_ID}
mkdir ENMIN
cd ENMIN 
gmx grompp -f ../../MDP/ENMIN/enmin.${TASK_ID}.mdp -c ../../$COMPLEX.gro -p ../../$COMPLEX.top -o enmin.tpr
gmx mdrun -v -stepout 1000 -s enmin.tpr -deffnm enmin -ntmpi 1
cd ../
mkdir NVT 
cd NVT
gmx grompp -f ../../MDP/NVT/nvt.${TASK_ID}.mdp -c ../ENMIN/enmin.gro -p ../../$COMPLEX.top -o nvt.tpr -r ../ENMIN/enmin.gro
gmx mdrun -v -stepout 1000 -s nvt.tpr -deffnm nvt -ntmpi 1
cd ../
mkdir NPT
cd NPT
gmx grompp -f ../../MDP/NPT/npt.${TASK_ID}.mdp -c ../NVT/nvt.gro -t ../NVT/nvt.cpt -p ../../$COMPLEX.top  -o npt.tpr -r ../NVT/nvt.gro
gmx mdrun -v -stepout 1000 -s npt.tpr -deffnm npt -ntmpi 1
cd ../
mkdir PROD
cd PROD
gmx grompp -f ../../MDP/PROD/prod.${TASK_ID}.mdp -c ../NPT/npt.gro -t ../NPT/npt.cpt -p ../../$COMPLEX.top  -o prod.tpr -r ../NPT/npt.gro
gmx mdrun -v -stepout 1000 -s prod.tpr -deffnm prod -dhdl dhdl -ntmpi 1
cd ../../
