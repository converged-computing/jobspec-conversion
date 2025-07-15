#!/bin/bash
#FLUX: --job-name=xxf
#FLUX: -N=8
#FLUX: --queue=cpuq
#FLUX: -t=86400
#FLUX: --priority=16

 echo "Start:"; date;
 echo "Running program on $SLURM_JOB_NUM_NODES nodes with $SLURM_NTASKS total tasks, with each node getting $SLURM_NTASKS_PER_NODE running on cores."
 module load intel/impi
 export OMP_NUM_THREADS=1
 MPICMD="mpirun -n $SLURM_NTASKS --ppn 40"
 PWDIR="/data/users/jxu153/codes/qe/qe-6.1.0/bin"
 YAMDIR=/data/users/jxu153/codes/yambo/yambo-4.1.4/bin
bands='900 1200 1500 1900 2000'
blocks='1 2 3 4 5 6 7 8'
for i in ${bands}
do
  for j in ${blocks}
  do
    $MPICMD $YAMDIR/yambo -F gw_conv_$i'b_'$j'Ry.in' -J $i'b_'$j'Ry'
  done
done
echo "Done"
echo "End:"; date
