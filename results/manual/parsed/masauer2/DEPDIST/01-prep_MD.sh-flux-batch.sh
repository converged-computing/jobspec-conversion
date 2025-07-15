#!/bin/bash
#FLUX: --job-name=red-salad-5424
#FLUX: --urgency=16

gmx=gmx_plumed
protein=complex.pdb
salt=0.15
files=(
complex.pdb
)
for file in ${files[@]}
do
if [ ! -f ${file} ]; then
echo "-could not find file ${file} in current directory"
echo "-you are either starting this in the wrong directory"
echo " or you missed a previous step"
echo "-exiting"
exit
fi
done
${gmx} pdb2gmx -f ${protein} -ignh -o complex.gro -p complex.top << STOP
6
1
STOP
${gmx} editconf -f complex.gro -box 8 8 8 -o box.gro >& editconf.out
${gmx} solvate -cp box.gro -cs -p complex.top -o solv.gro >& solvate.out
${gmx} grompp -f ions.mdp -c solv.gro -p complex.top -o ions.tpr
${gmx} genion -s ions.tpr -o ions.gro -p complex.top -pname NA -nname CL -neutral -conc ${salt} << STOP
13
STOP
mkdir em
cd em
${gmx} grompp -f ../em.mdp -c ../ions.gro -r ../ions.gro -p ../complex.top -o topol.tpr -maxwarn 1 >& grompp.out
${gmx} mdrun -v -nb gpu -s topol.tpr -o traj.trr -e ener.edr -g md.log -c confout.gro -cpo state.cpt >& mdrun.out
cd ..
mkdir equi-NPT
cd equi-NPT
${gmx} grompp -f ../equi-constrain.mdp -c ../em/confout.gro -r ../em/confout.gro -p ../complex.top -o topol.tpr -maxwarn 3 >& grompp.out
${gmx} mdrun -v -nb gpu -pme gpu -ntmpi 8 -ntomp 3 -npme 1 -s topol.tpr -o traj.trr -e ener.edr -g md.log -c confout.gro -cpo state.cpt >& mdrun.out
cd ..
