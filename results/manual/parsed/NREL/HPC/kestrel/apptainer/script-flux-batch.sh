#!/bin/bash
#FLUX: --job-name="apptainer"
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: -t=7200
#FLUX: --priority=16

export STARTDIR='`pwd`'
export CDIR='/nopt/nrel/apps/software/apptainer/1.1.9/examples'
export OMP_NUM_THREADS='2'

export STARTDIR=`pwd`
export CDIR=/nopt/nrel/apps/software/apptainer/1.1.9/examples
mkdir $SLURM_JOB_ID
cd $SLURM_JOB_ID
cat $0 >   script
printenv > env
touch warnings
touch output
module load apptainer
which apptainer >> output
echo "hostname" >> output
hostname        >> output
echo "from alpine.sif" >> output
          apptainer exec $CDIR/alpine.sif hostname  >> output
echo "from alpine.sif with srun" >> output
srun -n 1 --nodes=1 apptainer exec $CDIR/alpine.sif cat /etc/os-release  >> output
export OMP_NUM_THREADS=2
$CDIR/tymer times starting
MPI=pmix
for v in openmpi intel mpich_ch4 mpich_ch4b  mpich_ch3; do
  srun  --mpi=$MPI   apptainer  exec   $CDIR/$v.sif  /opt/examples/affinity/tds/phostone -F >  phost.$v  2>>warnings
  $CDIR/tymer times $v
  MPI=pmi2
  unset PMIX_MCA_gds
done
MPI=pmix
for v in openmpi intel mpich_ch4 mpich_ch4b           ; do
  srun  --mpi=$MPI   apptainer  exec   $CDIR/$v.sif  /opt/examples/affinity/tds/ppong>  ppong.$v  2>>warnings
  $CDIR/tymer times $v
  MPI=pmi2
  unset PMIX_MCA_gds
done
$CDIR/tymer times finished
mv $STARTDIR/apptainer.log .
