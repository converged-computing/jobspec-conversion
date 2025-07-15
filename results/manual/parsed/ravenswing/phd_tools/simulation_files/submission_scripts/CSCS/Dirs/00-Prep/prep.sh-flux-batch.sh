#!/bin/bash
#FLUX: --job-name=lin-para
#FLUX: --queue=normal
#FLUX: -t=3600
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export CRAY_CUDA_MPS='1'
export name='$(cd ..; basename -- "$PWD")'
export GMX='gmx'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export CRAY_CUDA_MPS=1
module load daint-gpu                                                             
module use /apps/daint/UES/6.0.UP07/sandboxes/hvictor/easybuild/modules/all        
module load GROMACS/2018-CrayGNU-18.08-PLUMED-2.4.2-cuda-9.1
export name=$(cd ..; basename -- "$PWD")
export GMX=gmx
for i in {1..2}
do 
    num=$(($i * 16))
    echo $num
    sed -i -e "/HE2 HIE    $num/a TER" ${name}_initial.pdb
done
echo 1 | $GMX pdb2gmx -f ${name}_initial.pdb -o ${name}_built.gro -p $name.top -ff amber_disp -ignh
$GMX editconf -f ${name}_built.gro -o ${name}_box.gro -c -d 1.2 -bt dodecahedron
$GMX solvate -cp ${name}_box.gro -cs tip4p.gro -o ${name}_sol.gro -p $name.top
sed -i -e '/SOL/ s/HW2/HW3/ ' ${name}_sol.gro
sed -i -e '/SOL/ s/HW1/HW2/ ' ${name}_sol.gro
sed -i -e '/SOL/ s/ MW/MW4/ ' ${name}_sol.gro
$GMX grompp -f prep.mdp -c ${name}_sol.gro -p $name.top -o ions.tpr
echo SOL | $GMX genion -s ions.tpr -o ${name}.gro -p $name.top -pname NA -nname CL -neutral -conc 0.15
$GMX grompp -f prep.mdp -c $name.gro -p $name.top -o reshape.tpr
echo System | $GMX trjconv -f $name.gro -s reshape.tpr -o Readable${name}.gro -pbc mol -ur compact
echo C-alpha | $GMX genrestr -f $name.gro -o posres_CAlpha.itp
