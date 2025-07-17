#!/bin/bash
#FLUX: --job-name=LAMMPSAPPEKG
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=wholenode
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='4'
export OMP_PLACES='cores'
export OMP_PROC_BIND='spread'

echo "anomalous run"
module load gcc/11.2.0
module load openmpi/4.0.6
INPUT=in.ar.lj
EXEC=../../../lmp_omp_appekg
EXECHPAS=/anvil/projects/x-cis230165/tools/HPAS/install/bin/hpas
export OMP_NUM_THREADS=4
export OMP_PLACES=cores
export OMP_PROC_BIND=spread
srun --overlap --ntasks-per-node=64 --cpu-bind=map_cpu:0,2,4,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,124,126 ${EXECHPAS}  cpuoccupy -u 70 &
time srun --ntasks-per-node=16 --cpus-per-task=8 --cpu-bind=map_cpu:0,2,4,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,124,126 ${EXEC} -sf omp -pk omp 4 -in ${INPUT}
