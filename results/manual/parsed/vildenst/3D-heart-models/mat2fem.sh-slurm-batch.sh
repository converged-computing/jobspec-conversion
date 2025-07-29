#!/bin/bash
#SBATCH --job-name=mat2fem
#SBATCH --account=nn9249k
#SBATCH --output=out.txt
#SBATCH --error=err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=1-00:00:00

source /cluster/bin/jobsetup
module purge
module load matlab/R2017a
module load python2/2.7.10
module load gcc/7.2.0
if [ $# -eq 0 ];then
	echo "Give the number of patients added to seg as an argument. Quitting."
	exit 1
fi
folder=seg/current_patient
data="`date +%d.%m-%H.%M`"
for i in $(seq 1 $1);do
	echo "Working on Patient $i"
	cp seg/Patient_"$i".mat $folder/Patient_1.mat
	python mat2fem.py $i $data
	rm $folder/Patient_1.mat
done
