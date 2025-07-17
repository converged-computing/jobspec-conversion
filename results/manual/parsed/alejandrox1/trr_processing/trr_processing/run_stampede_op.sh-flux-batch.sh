#!/bin/bash
#FLUX: --job-name=osmotic
#FLUX: -n=16
#FLUX: --exclusive
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --urgency=16

help=$(grep "^##" "${BASH_SOURCE[0]}" | cut -c 4-)
version=$(grep "^#-" "${BASH_SOURCE[0]}" | cut -c 4-)
opt_h() 
{
        echo "$help"
}
opt_v() 
{
        echo "$version"
}
while getopts "hv" opt; do
        eval "opt_$opt"
	exit
done
module load intel
module load impi
gmxdir=/home1/03561/alarcj/gromacs/exe/gromacs-4.0.7_flatbottom/exec/bin
input=$1
output=$input
water=$2
L="3.9"  #3.9
Nmg=$3
if [ $# -ne 3 ]; then
	if [ "$input" -ne "-h" ] || [ "$residue" -ne "-v" ]; then
		echo "ERROR: must run this script with three arguments."
		echo "\$1 = input structure."
		echo "\$2 = output name. No \".gro\""
		echo "\$3 = Number of residues."
		exit
	fi
fi
if [ "$input" == "pro" ]; then
	cp /scratch/03561/alarcj/topologies/proline/proline.top topol.top
	cp /scratch/03561/alarcj/topologies/proline/proline.gro pro.gro
	cp /scratch/03561/alarcj/topologies/proline/posre.itp posre.itp
else
	echo -e "5\n1\n1\n" | $gmxdir/pdb2gmx -f ${input}.pdb -water $water -o ${output}.gro -ignh -p topol.top -ter > parameters.txt #Parameters for GLY,TYR  
fi
$gmxdir/genbox -ci ${output}.gro -nmol $Nmg -box `echo "$L - 0.5" | bc -l` `echo "$L - 0.5" | bc -l` `echo "$L - 0.5" | bc -l` -p topol.top -o ${Nmg}_${output}.gro
if [ "$input" == "pro" ]; then
        sed -i "$ c Protein_chain_X \t ${Nmg}" topol.top
elif [ "$input" == "arg" ] || [ "$input" == "glu" ]; then
        sed -i "$ c Protein_X \t ${Nmg}" topol.top
else
        sed -i "$ c Protein \t ${Nmg}" topol.top
fi
$gmxdir/editconf -f ${Nmg}_${output}.gro -o ${output}_box.gro -box $L $L $L 
if [ "$water" == "tip3p" ]; then
	$gmxdir/genbox -cp ${output}_box -cs spc216.gro -p topol.top -o ${output}_solvated.gro
else
	if [ $water == "tip4p" ];then
        	$gmxdir/genbox -cp ${output}_box -cs $water -p topol.top -o ${output}_solvated.gro
	fi
fi
$gmxdir/grompp -f chamber_min.mdp -c ${output}_solvated.gro -p topol.top -o chamber_min.tpr 
ibrun $gmxdir/mdrun -v -deffnm chamber_min 
if [ "$water" == "tip3p" ];then
	$gmxdir/genbox -cs spc216.gro -box $L $L $L -o water_${L}nm.gro
else
	if [ "$water" == "tip4p" ];then
		$gmxdir/genbox -cs $water -box $L $L $L -o water_${L}nm.gro
	fi
fi
$gmxdir/editconf -f water_${L}nm.gro -o water_${L}nm_top.gro -box $L $L $L -center 0 0 `echo "scale=2; $L + $L/2" |bc -l`
$gmxdir/editconf -f chamber_min.gro -o central_shifted.gro -box $L $L $L -center 0 0 `echo "scale=2; $L/2" | bc -l`
./combine2gro.sh central_shifted.gro water_${L}nm_top.gro system.gro
if [ "$input" == "arg" ]; then
	$gmxdir/grompp -f min.mdp -c system.gro -p topol.top -o sys_ions.tpr >> parameters.txt
	echo -e "12\n" | $gmxdir/genion -s sys_ions.tpr -o sys_ions.gro -p topol.top -pname NA+ -nname CL- -nn $Nmg >> parameters.txt
	# Minimization
	$gmxdir/grompp -f min.mdp -c sys_ions.gro -p topol.top -o min.tpr
	ibrun $gmxdir/mdrun_mpi -np 16 -v -deffnm min 
	echo -e "0\n" | $gmxdir/trjconv -f min.trr -s min.tpr -pbc mol -o min.xtc
elif [ "$input" == "glu" ]; then
	$gmxdir/grompp -f min.mdp -c system.gro -p topol.top -o sys_ions.tpr >> parameters.txt
        echo -e "12\n" | $gmxdir/genion -s sys_ions.tpr -o sys_ions.gro -p topol.top -pname NA+ -nname CL- -np $Nmg >> parameters.txt
        # Minimization
        $gmxdir/grompp -f min.mdp -c sys_ions.gro -p topol.top -o min.tpr
        ibrun $gmxdir/mdrun_mpi -np 16 -v -deffnm min 
	echo -e "0\n" | $gmxdir/trjconv -f min.trr -s min.tpr -pbc mol -o min.xtc
else
	$gmxdir/grompp -f min.mdp -c system.gro -p topol.top -o min.tpr >> parameters.txt
	ibrun $gmxdir/mdrun_mpi -np 16 -v -deffnm min 
	echo -e "0\n" | $gmxdir/trjconv -f min.trr -s min.tpr -pbc mol -o min.xtc
fi
echo -e "0\nq\n" | $gmxdir/make_ndx -f min.gro -o index.ndx
$gmxdir/grompp -f nvt.mdp -c min.gro -n index.ndx -p topol.top -o nvt.tpr
ibrun $gmxdir/mdrun_mpi -np 16 -v -deffnm nvt 
echo -e "0\n" | $gmxdir/trjconv -f nvt.trr -s nvt.tpr -pbc mol -o nvt.xtc
./make_pull_mdp.sh simul.mdp nvt.gro $L $Nmg
rm \#*
rm *trr
