#!/bin/bash
#FLUX: --job-name=joyous-diablo-6757
#FLUX: --exclusive
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
module load mpi/openmpi
gmxdir=/home/alarcj/exe/gromacs-4.0.7_flatbottom/exec/bin
input=$1
output=$input
water=$2
L="3.0"
Nmg=1
if [ "$input" == "pro" ]; then
	if [ "$water" == "tip3p" ]; then
		cp /data/disk02/alarcj/data_base_stampede/topologies/proline/proline.top topol.top
		cp /data/disk02/alarcj/data_base_stampede/topologies/proline/proline.gro pro.gro
		cp /data/disk02/alarcj/data_base_stampede/topologies/proline/posre.itp posre.itp
	else
		if [ $water == "tip4p" ];then
			cp /data/disk02/alarcj/data_base_stampede/topologies/pro_tip4p/proline.top topol.top
			cp /data/disk02/alarcj/data_base_stampede/topologies/pro_tip4p/proline.gro pro.gro
			cp /data/disk02/alarcj/data_base_stampede/topologies/pro_tip4p/posre.itp posre.itp
		fi
	fi
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
$gmxdir/mdrun -v -deffnm chamber_min 
echo -e "0\n" | $gmxdir/trjconv -f chamber_min.trr -s chamber_min.tpr -pbc mol -o chamber_min.xtc
