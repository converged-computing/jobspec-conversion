#!/bin/bash
#SBATCH --job-name=lammps
#SBATCH --nodes=1
#SBATCH --ntasks=36
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=00:20:00
#SBATCH --partition=admin

export OMP_NUM_THREADS='36'

module load gcc/9.4.0 lammps/29Oct20
module list
EXECUTABLE=lmp
SCRATCH=$MYSCRATCH/run_lammps/$SLURM_JOBID
RESULTS=$MYGROUP/lmp_results/$SLURM_JOBID
export OMP_NUM_THREADS=36
if [ ! -d $SCRATCH ]; then 
    mkdir -p $SCRATCH 
fi 
echo SCRATCH is $SCRATCH
if [ ! -d $RESULTS ]; then 
    mkdir -p $RESULTS 
fi
echo the results directory is $RESULTS
OUTPUT=lammps.log
cp *.lmp $SCRATCH
cd $SCRATCH
lmp -sf gpu -pk gpu 1 -in epm2.lmp >> ${OUTPUT}
mv  $OUTPUT ${RESULTS}
cd $HOME
rm -r $SCRATCH
echo lammps_mpi job finished at  `date`
