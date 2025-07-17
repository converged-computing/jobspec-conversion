#!/bin/bash
#FLUX: --job-name=outstanding-omelette-1627
#FLUX: -N=2
#FLUX: -n=18
#FLUX: -c=4
#FLUX: --queue=short
#FLUX: -t=600
#FLUX: --urgency=16

export VER='icc'
export cpt='$SLURM_CPUS_PER_TASK '
export OMP_PLACES='cores'
export OMP_PROC_BIND='spread'

if [ -z ${VER+x} ]; then 
export VER=gcc
export VER=mpt
export VER=icc
fi
if [[ $SLURM_ARRAY_JOB_ID ]] ; then
	export JOB_ID=$SLURM_ARRAY_JOB_ID
else
	export JOB_ID=$SLURM_JOB_ID
fi
mkdir -p $VER/$JOB_ID
cd  $VER/$JOB_ID
module purge
if [[ "$VER" = "mpt" ]] ; then
	module load mpt/2.23 gcc/10.1.0
else
  if [[ "$VER" = "oin" ]] ; then
        module load openmpi/4.1.0/gcc-8.4.0  comp-intel/2020.1.217
  else
	module load intel-mpi/2020.1.217 gcc/10.1.0
  fi
fi
ml 2> $SLURM_JOB_ID.ver
echo VERSION=$VER >> $SLURM_JOB_ID.ver
printenv > $SLURM_JOB_ID.env
cat $0 > $SLURM_JOB_ID.script
export cpt=$SLURM_CPUS_PER_TASK 
export OMP_PLACES=cores
export OMP_PROC_BIND=spread
for n in `seq 1 $SLURM_CPUS_PER_TASK` ; do  
    request=`python -c "print($n*$SLURM_NTASKS)"`
    have=72
    if ((request <= have)); then 
      export OMP_NUM_THREADS=$n  
      srun  --ntasks-per-core=1 -n $SLURM_NTASKS $SLURM_SUBMIT_DIR/phostone.$VER -F -t 3 > $SLURM_JOB_ID.$SLURM_NTASKS.$OMP_NUM_THREADS
      cores=`cat $SLURM_JOB_ID.$SLURM_NTASKS.$OMP_NUM_THREADS | sort -k3,3 -k6,6 |awk '{print $3, $6}' | grep ^r | sort -u | wc -l`
      echo $cpt $SLURM_NTASKS $OMP_NUM_THREADS $cores >> $SLURM_JOB_ID.out
    fi
done 
