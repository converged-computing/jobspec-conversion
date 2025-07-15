#!/bin/bash
#FLUX: --job-name=dirty-kitty-5814
#FLUX: --urgency=16

module purge
module load apps/amber/18-19
rest="1 0.5 0.1 0.01 0.001 0"
for i in $rest;
do
    if [ "$i" = "1" ]; then 
	echo $i
	mpirun -np $SLURM_NTASKS -ppn $SLURM_NTASKS_PER_NODE sander.MPI -O -i eq-$i-$1.in -o eq-$i-$1.out -p dna-$1.prmtop -c heat-300-$1.rst -r eq-$i-$1.rst -x eq-$i-$1.mdcrd -inf eq-$i-$1.mdinfo -ref mini2-$1.ncrst
	# (general idea applies to each elif statement) MT - -np $SLURM_NTASKS - CPU cores handling jobs
	#MT - -ppn $SLURM_NTASKS_PER_NODE - tasks handled per node
	#MT - sander.MPI is san AMBER program used
	#MT - -i eq-$i-$1.in -o eq-$i-$1.out are established input and output files for script
	#MT - takes in parameter file, input coordinate file.
	#MT - -c heat-300-$1.rst -> input coordinates from said file for simulation
	#MT - -r eq-$i-$1.rst -> output coordinate files of molecule after equilibriating
	#MT - -x eq-$i-$1.mdcrd -> file where info for each position of atoms in molecule during equilibriating are saved
	#MT - -inf eq-$i-$1.mdinfo -> file that provides information about simulation progress in equilibriating 
	#MT - mini2-$1.ncrst ->  we use it to compare our simulated molecule after running the eq.sh script to see if it matches depending on our desires
    elif [ "$i" = "0.5" ]; then
	echo $i
	prev=1
	mpirun -np $SLURM_NTASKS -ppn $SLURM_NTASKS_PER_NODE sander.MPI -O -i eq-$i-$1.in -o eq-$i-$1.out -p dna-$1.prmtop -c eq-$prev-$1.rst -r eq-$i-$1.rst -x eq-$i-$1.mdcrd -inf eq-$i-$1.mdinfo -ref mini2-$1.ncrst
    elif [ "$i" = "0.1" ]; then
	echo $i
	prev=0.5
	mpirun -np $SLURM_NTASKS -ppn $SLURM_NTASKS_PER_NODE sander.MPI -O -i eq-$i-$1.in -o eq-$i-$1.out -p dna-$1.prmtop -c eq-$prev-$1.rst -r eq-$i-$1.rst -x eq-$i-$1.mdcrd -inf eq-$i-$1.mdinfo -ref mini2-$1.ncrst
    elif [ "$i" = "0.01" ]; then
	echo $i
	prev=0.1
	mpirun -np $SLURM_NTASKS -ppn $SLURM_NTASKS_PER_NODE sander.MPI -O -i eq-$i-$1.in -o eq-$i-$1.out -p dna-$1.prmtop -c eq-$prev-$1.rst -r eq-$i-$1.rst -x eq-$i-$1.mdcrd -inf eq-$i-$1.mdinfo -ref mini2-$1.ncrst
    elif [ "$i" = "0.001" ]; then
	echo $i
	prev=0.01
	mpirun -np $SLURM_NTASKS -ppn $SLURM_NTASKS_PER_NODE sander.MPI -O -i eq-$i-$1.in -o eq-$i-$1.out -p dna-$1.prmtop -c eq-$prev-$1.rst -r eq-$i-$1.rst -x eq-$i-$1.mdcrd -inf eq-$i-$1.mdinfo -ref mini2-$1.ncrst
    elif [ "$i" = "0" ]; then
	echo $i
	prev=0.001
	mpirun -np $SLURM_NTASKS -ppn $SLURM_NTASKS_PER_NODE sander.MPI -O -i eq-$i-$1.in -o eq-$i-$1.out -p dna-$1.prmtop -c eq-$prev-$1.rst -r eq-$i-$1.rst -x eq-$i-$1.mdcrd -inf eq-$i-$1.mdinfo -ref mini2-$1.ncrst
    fi
done
