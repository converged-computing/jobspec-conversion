#!/bin/bash
#FLUX: --job-name=stanky-dog-9900
#FLUX: --exclusive
#FLUX: --priority=16

help=$(grep "^#-" "${BASH_SOURCE[0]}" | cut -c 4-)
opt_h() 
{
        echo "$help"
}
while getopts "hv" opt; do
        eval "opt_$opt"
	exit
done
cluster=$1
n=$2
input=$3
water=$4
Nmg=$5
param_lj=$6
param_qq=$7
output=$input
L="3.9"  
echo $cluster
case "$cluster" in
	"stampede")
                module load intel
		module load impi
		gmxdir=/home1/03561/alarcj/gromacs/exe/gromacs-4.0.7_flatbottom/exec/bin
		top_pro_3p=/scratch/03561/alarcj/data/topologies/pro_tip3p
		top_pro_4p=/scratch/03561/alarcj/data/topologies/pro_tip4p	
		ibrun=ibrun
                ;;
        "comet")
		module load intel
		module load openmpi_ib/1.8.4
		gmxdir=/home/alarcj/gromacs_stampede/exe/gromacs-4.0.7_flatbottom/exec/bin
		top_pro_3p=/oasis/scratch/comet/alarcj/temp_project/data/topologies/pro_tip3p
		top_pro_4p=/oasis/scratch/comet/alarcj/temp_project/data/topologies/pro_tip4p
		ibrun=ibrun
                ;;
        "terra" | "gaia")
                module load mpi/openmpi
		gmxdir=/home/alarcj/exe/gromacs-4.0.7_flatbottom/exec/bin
		top_pro_3p=/data/disk04/alarcj/data/topologies/pro_tip3p
		top_pro_4p=/data/disk04/alarcj/data/topologies/pro_tip4p
		ibrun=mpirun
                ;;
        *)
                echo "Unkown option."
                exit
esac
if [ "$input" == "pro" ] && [ "$water" == "tip3p" ]; then
	cp ${top_pro_3p}/proline.top topol.top
	cp ${top_pro_3p}/proline.gro pro.gro
	cp ${top_pro_3p}/posre.itp posre.itp
elif [ "$input" == "pro" ] && [ "$water" == "tip4p" ]; then
	cp ${top_pro_4p}/proline.top topol.top
        cp ${top_pro_3p}/proline.gro pro.gro
	cp ${top_pro_3p}/posre.itp posre.itp
else
	echo -e "5\n1\n1\n" | $gmxdir/pdb2gmx -f ${input}.pdb -water $water -o ${output}.gro -ignh -p topol.top -ter > parameters.txt 
fi
$gmxdir/genbox -ci ${output}.gro -nmol $Nmg -box `echo "$L - 0.5" | bc -l` `echo "$L - 0.5" | bc -l` `echo "$L - 0.5" | bc -l` -p topol.top -o ${Nmg}_${output}.gro
if [ "$input" == "pro" ]; then
        sed -i "$ c Protein_chain_X \t ${Nmg}" topol.top
elif [ "$input" == "arg" ] || [ "$input" == "glu" ]; then
        sed -i "$ c Protein_X \t ${Nmg}" topol.top
else
        sed -i "$ c Protein \t ${Nmg}" topol.top
fi
bash fudge.sh $param_lj $param_qq 
$gmxdir/editconf -f ${Nmg}_${output}.gro -o ${output}_box.gro -box $L $L $L 
if [ "$water" == "tip3p" ]; then
	$gmxdir/genbox -cp ${output}_box -cs spc216.gro -p topol.top -o ${output}_solvated.gro
elif [ $water == "tip4p" ];then
       	$gmxdir/genbox -cp ${output}_box -cs $water -p topol.top -o ${output}_solvated.gro
fi
$gmxdir/grompp -f chamber_min.mdp -c ${output}_solvated.gro -p topol.top -o chamber_min.tpr 
${ibrun} -np ${n} $gmxdir/mdrun_mpi -v -deffnm chamber_min 
if [ "$water" == "tip3p" ];then
	$gmxdir/genbox -cs spc216.gro -box $L $L $L -o water_${L}nm.gro
elif [ "$water" == "tip4p" ];then
	$gmxdir/genbox -cs $water -box $L $L $L -o water_${L}nm.gro
fi
$gmxdir/editconf -f water_${L}nm.gro -o water_${L}nm_top.gro -box $L $L $L -center 0 0 `echo "scale=2; $L + $L/2" |bc -l`
$gmxdir/editconf -f chamber_min.gro -o central_shifted.gro -box $L $L $L -center 0 0 `echo "scale=2; $L/2" | bc -l`
./combine2gro.sh central_shifted.gro water_${L}nm_top.gro system.gro
if [ "$input" == "arg" ]; then
	$gmxdir/grompp -f min.mdp -c system.gro -p topol.top -o sys_ions.tpr >> parameters.txt
	echo -e "12\n" | $gmxdir/genion -s sys_ions.tpr -o sys_ions.gro -p topol.top -pname NA+ -nname CL- -nn $Nmg >> parameters.txt
	# Minimization
	$gmxdir/grompp -f min.mdp -c sys_ions.gro -p topol.top -o min.tpr
	${ibrun} -np ${n} $gmxdir/mdrun_mpi  -v -deffnm min 
	echo -e "0\n" | $gmxdir/trjconv -f min.trr -s min.tpr -pbc mol -o min.xtc
elif [ "$input" == "glu" ]; then
	$gmxdir/grompp -f min.mdp -c system.gro -p topol.top -o sys_ions.tpr >> parameters.txt
        echo -e "12\n" | $gmxdir/genion -s sys_ions.tpr -o sys_ions.gro -p topol.top -pname NA+ -nname CL- -np $Nmg >> parameters.txt
        # Minimization
        $gmxdir/grompp -f min.mdp -c sys_ions.gro -p topol.top -o min.tpr
        ${ibrun} -np ${n} $gmxdir/mdrun_mpi -v -deffnm min 
	echo -e "0\n" | $gmxdir/trjconv -f min.trr -s min.tpr -pbc mol -o min.xtc
else
	$gmxdir/grompp -f min.mdp -c system.gro -p topol.top -o min.tpr >> parameters.txt
	${ibrun} -np ${n} $gmxdir/mdrun_mpi -v -deffnm min 
	echo -e "0\n" | $gmxdir/trjconv -f min.trr -s min.tpr -pbc mol -o min.xtc
fi
echo -e "0\nq\n" | $gmxdir/make_ndx -f min.gro -o index.ndx
$gmxdir/grompp -f nvt.mdp -c min.gro -n index.ndx -p topol.top -o nvt.tpr
${ibrun} -np ${n} $gmxdir/mdrun_mpi -v -deffnm nvt 
echo -e "0\n" | $gmxdir/trjconv -f nvt.trr -s nvt.tpr -pbc mol -o nvt.xtc
case "$cluster" in
	"stampede")
		./make_pull_mdp.sh simul.mdp nvt.gro $L $Nmg 
		;;
	"comet")
		./make_pull_mdp_comet.sh simul.mdp nvt.gro $L $Nmg
		;;
	"terra"|"gaia")
		./make_pull_mdp_terra.sh simul.mdp nvt.gro $L $Nmg
esac
rm \#*
