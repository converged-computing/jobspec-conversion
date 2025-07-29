#!/bin/bash
#FLUX: --job-name=runoff-remap
#FLUX: --queue=t1small
#FLUX: -t=86400
#FLUX: --urgency=16

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
