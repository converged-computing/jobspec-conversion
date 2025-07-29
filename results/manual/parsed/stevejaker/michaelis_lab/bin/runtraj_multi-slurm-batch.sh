#!/bin/bash
#SBATCH --mail-user=sjaker12@byu.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --time=00:01:00
#SBATCH --constraint=ntasks-per-node=16
#SBATCH --array=1-43%1

. /etc/profile
loadamber 
echo "Running cpptraj.MPI for Catalyst atom ${SLURM_ARRAY_TASK_ID}"
mpirun -np 16 cpptraj.MPI -i cpptraj_C${SLURM_ARRAY_TASK_ID}_S.in
echo "Finished cpptraj.mpi"
echo "
Running location.py
"
case $1 in
	-o | -O )
	case $2 in
		"" | " " )
			outfile=all_contacts.dat
			;;
		* )
			outfile=$2
			;;
	esac
		python location.py -i distance_C_${SLURM_ARRAY_TASK_ID}_S_all.dat -o ${outfile}.dat
		;;
	* )
		python location.py -i distance_C_${SLURM_ARRAY_TASK_ID}_S_all.dat
		;;
esac
echo "
DONE!
"
