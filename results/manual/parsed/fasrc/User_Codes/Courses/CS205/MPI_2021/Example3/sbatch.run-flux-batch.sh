#!/bin/bash
#FLUX: --job-name=bumfuzzled-poodle-4133
#FLUX: --priority=16

PRO=mpi_pi
rm -rf ${PRO}.dat
touch ${PRO}.dat
module load gcc/10.2.0-fasrc01 openmpi/4.1.1-fasrc01
for i in 1 2 4 8 16
do
    echo "Number of processes: ${i}" >> ${PRO}.dat
    srun -n ${i} --mpi=pmix ./${PRO}.x 1000000000 >> ${PRO}.dat
    echo " "
done
cat mpi_pi.dat  | grep -e Number -e time | awk '{if (NR%2 == 1 ){printf "%s ", $4}else{print $4}}'  > scaling_results.txt
sleep 2
module load python/3.8.5-fasrc01
python speedup.py
