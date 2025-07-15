#!/bin/bash
#FLUX: --job-name=runoff-remap
#FLUX: --priority=16

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
python make_river_file.py 2014
python add_rivers.py Hill_rivers_2014.nc
python make_river_clim.py discharge_2014_q_Hill_NWGOA.nc Hill_rivers_2014.nc
python set_vshape.py Hill_rivers_2014.nc
TEND=`echo "print time();" | perl`
echo " "
echo "++++ Chinook ++++ $PGM_NAME pwd:      `pwd`"
echo "++++ Chinook ++++ $PGM_NAME ended:    `date`"
echo "++++ Chinook ++++ $PGM_NAME walltime: `expr $TEND - $TBEGIN` seconds"
