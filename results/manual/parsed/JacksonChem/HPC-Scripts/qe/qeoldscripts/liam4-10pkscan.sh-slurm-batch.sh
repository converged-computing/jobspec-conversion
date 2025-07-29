#!/bin/bash
#SBATCH --job-name=liam4-10pkscan.qe
#SBATCH --output=/dev/null
#SBATCH --error=liam4-10pkscan.e%j
#SBATCH --mail-user=baj0040@auburn.edu
#SBATCH --mail-type=NONE
#SBATCH --nodes=1
#SBATCH --ntasks=50
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=240GB
#SBATCH --time=8-08:00:00

NPROC=50
CURDIR=$(pwd)
FNAME=liam4-10pkscan
cd ${CURDIR}
module load espresso/intel/6.8
i=2
while [[ $i -lt 5 ]]; do
	sed -i 179c"$i $i $i 0 0 0" ${CURDIR}/${FNAME}.in
	echo "k_points $i $i $i 0 0 0" >> ${CURDIR}/${FNAME}.out
	mpirun -n ${NPROC} /tools/espresso-6.8/bin/pw.x -inp ${CURDIR}/${FNAME}.in >> ${CURDIR}/${FNAME}.out
	((i++))
done
if [[ ! -s ${FNAME}.e${SLURM_JOB_ID} ]]; then 
  rm - f ${FNAME}.e${SLURM_JOB_ID}
fi
exit 0
