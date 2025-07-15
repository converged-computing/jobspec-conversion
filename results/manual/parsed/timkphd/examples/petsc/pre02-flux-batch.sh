#!/bin/bash
#FLUX: --job-name="petsc"
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --priority=16

module purge
ml gcc/7.3.0 comp-intel/2018.0.3 intel-mpi/2018.0.3 mkl/2018.3.222
cd $SLURM_SUBMIT_DIR
mkdir $SLURM_JOB_ID
cd $SLURM_JOB_ID
cat $0 > script
printenv > env
startdir=`pwd`
nm="1000"
tasks_per_node="8"
threads="4"
 for pc in jacobi bjacobi sor eisenstat         asm gasm gamg      ksp                       none ; do
for grid in $nm ; do
    for t1 in $tasks_per_node ; do 
        for t2 in $threads ; do 
          tot=`expr $t1 \* $t2`
          if [ $tot -le 36 ] ; then
               export OMP_NUM_THREADS=$t2
               newdir=`echo $grid/$t1/$t2`
               mkdir -p $newdir
               cd $newdir
               tymer $SLURM_SUBMIT_DIR/$SLURM_JOB_ID/times $newdir $pc start
               srun --ntasks-per-node=$t1 --cpus-per-task=$OMP_NUM_THREADS $SLURM_SUBMIT_DIR/ex16 -log_view -ksp_converged_reason -n $grid -m $grid -pc_type $pc  1> $pc 2> notes.$pc
               tymer $SLURM_SUBMIT_DIR/$SLURM_JOB_ID/times $newdir $pc end
               cd $startdir
          fi
        done
     done
done
done
