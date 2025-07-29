#!/bin/bash
#SBATCH --account=su007-rr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3850
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-9

NO_OF_SAMPLES=7
NOOFSTEPS=30
OFFSETVAL=0
MULTIPLY_DIVIDE=0
SPINANGLESTART=0
SPINANGLEEND=0.49
SPIANGLEDTH=0.05
SYMMETRISE=0
READIN=0
READINADDRESS=0
currdir=`pwd`'/../data'
cd $currdir
jobdir="TRIRG-$NOOFSAMPLES-$NOOFSTEPS"
mkdir -p $jobdir
jobfile=`printf "$jobdir.slurm"`
logfile=`printf "$jobdir.log"`
cd $jobdir
cat > ${jobfile} << EOD
module purge
module load GCC/12.2.0
module load CMake/3.22.1
module load Eigen/3.4.0
cmake ../CCTRI/
cmake --build .
srun ${jobdir}/TRIRG ${NOOFSAMPLES} ${NOOFSTEPS} ${OFFSETVAL} ${MULTIPLY_DIVIDE} $(($SPINANGLESTART+($SPINANGLEDTH*$SLURM_ARRAY_TASK_ID))) ${SYMMETRISE} ${READIN} ${READINADDRESS}
EOD
sbatch $jobfile
