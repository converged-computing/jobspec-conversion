#!/bin/bash
#SBATCH --job-name=lammps_mpi
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=workq

module swap PrgEnv-cray PrgEnv-gnu
module load lammps
module list
EXECUTABLE=lmp_mpi
SCRATCH=$MYSCRATCH/run_lammps/$SLURM_JOBID
RESULTS=$MYGROUP/lmp_mpi_results/$SLURM_JOBID
if [ ! -d $SCRATCH ]; then 
    mkdir -p $SCRATCH 
fi 
echo SCRATCH is $SCRATCH
if [ ! -d $RESULTS ]; then 
    mkdir -p $RESULTS 
fi
echo the results directory is $RESULTS
OUTPUT=lammps_mpi.log
cp *.lmp $SCRATCH
cd $SCRATCH
aprun -n 48 -N 24 $EXECUTABLE < epm2.lmp >> ${OUTPUT}
mv  $OUTPUT ${RESULTS}
cd $HOME
rm -r $SCRATCH
echo lammps_mpi job finished at  `date`
module swap PrgEnv-gnu PrgEnv-cray
