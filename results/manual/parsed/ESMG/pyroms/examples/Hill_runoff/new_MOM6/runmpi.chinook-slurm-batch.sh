#!/bin/bash
#SBATCH --job-name=runoff-remap
#SBATCH --account=akwaters
#SBATCH --output=bdry.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --no-requeue

cd $SLURM_SUBMIT_DIR
. /usr/share/Modules/init/bash
module purge
module load toolchain/foss/2016b
module list
source activate snowdrift
echo " "
echo "++++ Chinook ++++ $PGM_NAME began:    `date`"
echo "++++ Chinook ++++ $PGM_NAME hostname: `hostname`"
echo "++++ Chinook ++++ $PGM_NAME uname -a: `uname -a`"
echo " "
TBEGIN=`echo "print time();" | perl`
which python
for year in {2015..2021}
do
  python make_river_file.py ${year}
done
TEND=`echo "print time();" | perl`
echo " "
echo "++++ Chinook ++++ $PGM_NAME pwd:      `pwd`"
echo "++++ Chinook ++++ $PGM_NAME ended:    `date`"
echo "++++ Chinook ++++ $PGM_NAME walltime: `expr $TEND - $TBEGIN` seconds"
