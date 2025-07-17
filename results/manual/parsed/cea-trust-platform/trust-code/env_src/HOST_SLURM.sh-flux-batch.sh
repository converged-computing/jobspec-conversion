#!/bin/bash
#FLUX: --job-name=expensive-destiny-7055
#FLUX: --urgency=16

define_modules_config()
{
   env=$TRUST_ROOT/env/machine.env
   #
   # Load modules
   # intel 
   #intel=""
   # mpi
   #module="$intel "
   #
   #echo "# Module $module detected and loaded on $HOST."
   #echo "module purge 1>/dev/null" >> $env
   #echo "module load $module 1>/dev/null" >> $env     
   . $env
   # Creation wrapper qstat -> squeue
   echo "#!/bin/bash
squeue" > $TRUST_ROOT/bin/qstat
   chmod +x $TRUST_ROOT/bin/qstat
}
define_soumission_batch()
{
   soumission=2 && [ "$prod" = 1 ] && soumission=1
   cpu=30 && [ "$prod" = 1 ] && cpu=1440 # 30 minutes or 1 day
   #ram=64G && [ "$bigmem" = 1 ] && ram=128G # 64 GB or 128 GB
   # sacctmgr list qos format=Name,Priority,MaxSubmit,MaxWall,MaxNodes :
   qos=""
   # sinfo :
   queue=""
   # specific data cluster
   #ntasks=20
   #if [ "$prod" = 1 ] || [ $NB_PROCS -gt $ntasks ]
   #then
   #   node=1
   #   if [ "`echo $NB_PROCS | awk -v n=$ntasks '{print $1%n}'`" != 0 ]
   #   then
   #      echo "=================================================================================================================="
   #      echo "Warning: the allocated nodes of $ntasks cores will not be shared with other jobs (--exclusive option used)"
   #      echo "so please try to fill the allocated nodes by partitioning your mesh with multiple of $ntasks."
   #      echo "=================================================================================================================="
   #   fi
   #else
   #  node=0
   #fi
   #noeuds=`echo "$NB_PROCS/$ntasks+1" | bc`
   #[ `echo "$NB_PROCS%$ntasks" | bc -l` = 0 ] && noeuds=`echo "$NB_PROCS/$ntasks" | bc`
   #[ "$noeuds" = 0 ] && noeuds=1
   # Slurm srun support
   mpirun="srun -n \$SLURM_NTASKS"
   #mpirun="mpirun -np \$SLURM_NTASKS"
   sub=SLURM
}
