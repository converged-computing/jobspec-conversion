#!/bin/bash
#FLUX: --job-name=fugly-kerfuffle-2142
#FLUX: -N=16
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export CRAY_CUDA_MPS='1'
export FN='$(cd ..; basename -- "$PWD")'
export GMX='gmx'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export CRAY_CUDA_MPS=1
module load daint-gpu                                                             
module use /apps/daint/UES/6.0.UP07/sandboxes/hvictor/easybuild/modules/all        
module load GROMACS/2018-CrayGNU-18.08-PLUMED-2.4.2-cuda-9.1
export FN=$(cd ..; basename -- "$PWD")
export GMX=gmx
cp ../00-Prep/i.ndx .
cp ../00-Prep/EKEK_Protein*.itp . 
cp ../01-Min/min.tpr .
cp ../05-MD/$FN.top .
cp ../05-MD/${FN}_lastframe.gro .
cat plumed.dat > plumed_$FN.dat
num=$((`grep -B 1 'SOL' ${FN}_lastframe.gro | head -n 1 | awk '{ print $3 }'`))
echo -e "\nTerminal LIGAND atom number:"
echo -e "\t$num\n"
sed -i "s/????/$num/g" plumed_$FN.dat
$GMX grompp -f mdrun.mdp -c ${FN}_lastframe.gro -p ${FN}.top -o mdrun.tpr -r ${FN}_lastframe.gro -n i.ndx -pp processed.top
srun gmx_mpi mdrun -s mdrun.tpr -ntomp 1 -deffnm MDrun -plumed plumed_$FN.dat -maxh 23.5
cp MDrun.cpt MDrun_1.cpt
cp MDrun_prev.cpt MDrun_1_prev.cpt
