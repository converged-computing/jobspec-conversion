#!/bin/bash
#FLUX: --job-name=$LIGAND
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load cmake/cmake-3.15.4  cuda/cuda-10.2   intel/intel18   fftw/fftw3.3.8.i18  gcc/gcc-8
gmx=/b/home/isis/acerdan/gromacs-2020.3/build/bin/gmx
cp $RUNDIR/tutto.pdb $WORKDIR
ln -s /storage/kgalentino/cgenff/charmm36-feb2021.ff .
scp -r /storage/kgalentino/COMMANDS-POST-DOCKING/SRC $WORKDIR
scp -r /storage/kgalentino/COMMANDS-POST-DOCKING/MDP $WORKDIR
cp mol.itp MOL.itp
cp mol.prm MOL.prm
mv MOL.* charmm36-feb2021.ff/
cat tutto.pdb mol_ini.pdb >> complex.pdb
pdb=complex.pdb
cat SRC/topol-complex.tmpl |\
sed s/YYYY/MOL/g > topol-complex.top
$gmx editconf -f $pdb  -o init.gro -d 1.5 -bt cubic
$gmx grompp -f SRC/MINI1.mdp -c init.gro -p topol-complex.top -o mini1.tpr -maxwarn 2
$gmx mdrun -v -deffnm mini1
$gmx grompp -f SRC/MINI2.mdp -c mini1.gro -p topol-complex.top -o mini2.tpr -maxwarn 2
$gmx mdrun -v -deffnm mini2 >& tmp
nStep=`grep "Step" tmp | tail -1 | awk '{print $2+0}' | sed s/","//g`
echo "0" | $gmx trjconv -f mini2.trr -s mini2.tpr -o complex_min.pdb -b $nStep
rm \#*
rm tmp
rm init*
rm mini*
$gmx editconf -f complex_min.pdb -o complex.gro -bt dodecahedron -d 1.5
$gmx solvate -cp complex.gro -cs spc216.gro -p topol-complex.top -o solv.gro
$gmx grompp -f ions.mdp -c solv.gro -p topol-complex.top -o ions.tpr -maxwarn 1
echo "23" | $gmx genion -s ions.tpr -o solv_ions.gro -p topol-complex.top -pname SOD -nname CLA -neutral 
$gmx grompp -f MDP/mini.mdp -c solv_ions.gro -p topol-complex.top -o mini.tpr -maxwarn 2
$gmx mdrun -v -deffnm mini
$gmx  grompp  -f MDP/nvt.mdp -c mini.gro -p topol-complex.top -o nvt.tpr -maxwarn 1
$gmx mdrun -stepout 1000 -s nvt.tpr -deffnm nvt -v  -ntmpi 1 -ntomp 10
$gmx  grompp  -f MDP/npt.mdp -c nvt.gro -p -t nvt.cpt topol-complex.top -o npt.tpr -maxwarn 1
$gmx mdrun -stepout 1000 -s npt.tpr -deffnm npt -v  -ntmpi 1 -ntomp 10
$gmx  grompp   -f MDP/prod.mdp -c npt.gro -t npt.cpt -p topol-complex.top -o prod.tpr -maxwarn 1
$gmx  mdrun -stepout 1000 -s prod.tpr -deffnm prod  -dhdl dhdl -v -ntmpi 1 -ntomp 10
echo -e "4\n 0" | $gmx trjconv -f prod.xtc -s prod.tpr -skip 10 -center -pbc mol -o prod-10frames.xtc
exit
