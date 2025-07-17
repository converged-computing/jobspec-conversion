#!/bin/bash
#FLUX: --job-name=HM_init
#FLUX: --queue=pbatch
#FLUX: -t=3600
#FLUX: --urgency=16

source ~/.bashrc
setup () {
	mkdir "$2"
	cd "$2"
	### energy minimization ###
	mkdir em
	cd em
	python2.7 ../../scripts/insane.py $1
	cat ../../files/header.txt top.top > topol.top
	sed -i '5d' topol.top
	cp ../../files/minimization.mdp ../em/
	(echo del 1-200; echo "r W | r NA+ | r CL-"; echo name 1 Solvent; echo !1; echo name 2 Membrane; echo q) | gmx make_ndx -f bilayer.gro -o index.ndx
	gmx grompp -f minimization.mdp -c bilayer.gro -p topol.top -n index.ndx -o em.tpr
	gmx mdrun -deffnm em -v -nt 1
	cd ..
	### 1fs ###
	mkdir 1fs
	cp em/em.gro em/topol.top em/index.ndx 1fs
	cd 1fs
	cp ../../files/martini_v2.x_new-rf.1fs.mdp ../em/index.ndx ../1fs/
	gmx grompp -f martini_v2.x_new-rf.1fs.mdp -c em.gro -p topol.top -n index.ndx -o 1fs.tpr
	gmx mdrun -deffnm 1fs -v -nt 2 -dlb yes
	cd ..
	### 5fs ### 
	mkdir 5fs
	cp 1fs/1fs.gro 1fs/topol.top 1fs/index.ndx 5fs
	cd 5fs
	cp ../../files/martini_v2.x_new-rf.5fs.mdp ../1fs/index.ndx ../5fs/
	gmx grompp -f martini_v2.x_new-rf.5fs.mdp -c 1fs.gro -p topol.top -n index.ndx -o 5fs.tpr
	gmx mdrun -deffnm 5fs -v -nt 4 -dlb yes
	cd ..
	### 15fs ###
	mkdir 15fs
	cp 5fs/5fs.gro 5fs/topol.top 5fs/index.ndx 15fs
	cd 15fs
	cp ../../files/martini_v2.x_new-rf.15fs.mdp ../5fs/index.ndx ../15fs/
	gmx grompp -f martini_v2.x_new-rf.15fs.mdp -c 5fs.gro -p topol.top -n index.ndx -o 15fs.tpr
	gmx mdrun -deffnm 15fs -v -nt 4 -dlb yes
	cd ..
	### 20fs ###
	mkdir 20fs
	cp 15fs/15fs.gro 15fs/topol.top 15fs/index.ndx 20fs
	cd 20fs
	cp ../../files/martini_v2.x_new-rf.prod_run.mdp ../20fs/
	gmx grompp -f martini_v2.x_new-rf.prod_run.mdp -c 15fs.gro -p topol.top -n index.ndx -o 20fs.tpr
	cd ..
	# check whether setup finished correctly
	if [ -e "20fs/15fs.gro" ]
	then
		### clean up ###
		rm -r em
		rm -r 1fs
		rm -r 5fs
		rm -r 15fs
		cd ..
	else
		### try again ###
		cd ..
		rm -r "$2"
		setup "$1" "$2"
	fi
}
setup "$1" "$2" &
setup "$3" "$4" &
setup "$5" "$6" &
setup "$7" "$8" &
wait
sbatch run-syrah.sh 10 $2 $4 $6 $8
