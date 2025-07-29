#!/bin/bash
#FLUX: --job-name=prep
#FLUX: --queue=prepost
#FLUX: -t=1800
#FLUX: --urgency=16

export name='$(cd ..; basename -- "$PWD")'
export GMX='gmx'

module load daint-gpu                                                             
module use /apps/daint/UES/6.0.UP07/sandboxes/hvictor/easybuild/modules/all        
module load GROMACS/2018-CrayGNU-18.08-PLUMED-2.4.2-cuda-9.1
export name=$(cd ..; basename -- "$PWD")
export GMX=gmx
echo -e " 1 | 13 \n q" | gmx make_ndx -f ${name}_edited.gro -o i.ndx
$GMX editconf -f ${name}_edited.gro -o ${name}_box.gro -c -d 1.0 -bt dodecahedron
$GMX solvate -cp ${name}_box.gro -cs tip4p.gro -o ${name}_sol.gro -p topol.top          # TIP4P / TIP4P-D
sed -i -e '/SOL/ s/HW2/HW3/ ' ${name}_sol.gro
sed -i -e '/SOL/ s/HW1/HW2/ ' ${name}_sol.gro
sed -i -e '/SOL/ s/ MW/MW4/ ' ${name}_sol.gro
$GMX grompp -f prep.mdp -c ${name}_sol.gro -p topol.top -o ions.tpr -n i.ndx -maxwarn 1
echo SOL | $GMX genion -s ions.tpr -o ${name}.gro -p topol.top -pname NA -nname CL -neutral -conc 0.15
$GMX grompp -f prep.mdp -c $name.gro -p topol.top -o reshape.tpr -n i.ndx
echo System | $GMX trjconv -f $name.gro -s reshape.tpr -o Readable${name}.gro -pbc mol -ur compact
echo C-alpha | $GMX genrestr -f $name.gro -o posres_CAlpha.itp
echo 0 | $GMX genrestr -f ${name}_ligand_crystal.gro -o posre_lig.itp
echo Protein | $GMX genrestr -f $name.gro -o posre_prot.itp
echo -e " 1 | 13 \n q" | gmx make_ndx -f ${name}.gro -o i.ndx
