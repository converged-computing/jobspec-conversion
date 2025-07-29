#!/bin/bash
#SBATCH --job-name=xxf
#SBATCH --account=windfall
#SBATCH --output=qe.%j
#SBATCH --mail-user=kli103@ucsc.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=windfall
#SBATCH --constraint=ntasks-per-node=40
#SBATCH --dependency=518

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
