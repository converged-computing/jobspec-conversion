#!/bin/bash
#FLUX: --job-name=liam4-10pkscan.qe
#FLUX: -n=50
#FLUX: --queue=amd
#FLUX: -t=720000
#FLUX: --urgency=16

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
