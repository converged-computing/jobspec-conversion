#!/bin/bash
#FLUX: --job-name=xxf
#FLUX: -N=8
#FLUX: --queue=windfall
#FLUX: -t=86400
#FLUX: --urgency=16

 echo "Start:"; date;
 echo "Running program on $SLURM_JOB_NUM_NODES nodes with $SLURM_NTASKS total tasks, with each node getting $SLURM_NTASKS_PER_NODE running on cores."
 module load intel/impi
 export OMP_NUM_THREADS=1
 MPICMD="mpirun -n $SLURM_NTASKS --ppn 40"
 PWDIR="/data/users/jxu153/codes/qe/qe-6.1.0/bin"
 YAMDIR=/data/users/jxu153/codes/yambo/yambo-4.1.4/bin
 $MPICMD $YAMDIR/yambo -F gw_ff.in -J all_Bz
 echo "Done"
 echo "End:"; date
