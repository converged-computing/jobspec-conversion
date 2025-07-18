#!/bin/bash
#FLUX: --job-name=petsc
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
ml gcc/7.3.0 comp-intel/2018.0.3 intel-mpi/2018.0.3 mkl/2018.3.222
cd $SLURM_SUBMIT_DIR
mkdir $SLURM_JOB_ID
cd $SLURM_JOB_ID
cat $0 > script
printenv > env
startdir=`pwd`
nm="100 300 200 400 800 1000 1400 1700 2000"
tasks_per_node="4 8 10 12 18 36"
threads="1 2 3 4 8"
for grid in $nm ; do
    for t1 in $tasks_per_node ; do 
        for t2 in $threads ; do 
          tot=`expr $t1 \* $t2`
          if [ $tot -le 36 ] ; then
               export OMP_NUM_THREADS=$t2
               newdir=`echo $grid/$t1/$t2`
               mkdir -p $newdir
               cd $newdir
               tymer $SLURM_SUBMIT_DIR/$SLURM_JOB_ID/times $newdir start
               srun --ntasks-per-node=$t1 --cpus-per-task=$OMP_NUM_THREADS $SLURM_SUBMIT_DIR/ex16.sky -log_view -ksp_converged_reason -n $grid -m $grid  1> stdout 2> notes
               tymer $SLURM_SUBMIT_DIR/$SLURM_JOB_ID/times $newdir end
               cd $startdir
          fi
        done
     done
done
