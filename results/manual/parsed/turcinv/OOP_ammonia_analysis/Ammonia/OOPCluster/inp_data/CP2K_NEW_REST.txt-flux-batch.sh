#!/bin/bash
#FLUX: --job-name="ch102"
#FLUX: -N=4
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --priority=16

input=cluster_hybrid.inp
log=cluster_hybrid.log
source /opt/uochb/soft/spack/latest/share/spack/setup-env.sh #openmpi 3.1.6
spack env activate cp2k71
cp2k=cp2k.psmp
echo ' started at:' `date`
echo '   hostname:' `hostname`
echo " "
srun --mpi=pmix $cp2k $input >> $log
echo 'finished at:' `date`
dt="$(date '+%d/%m/%Y')"
finish="07/05/2022"
echo $dt
