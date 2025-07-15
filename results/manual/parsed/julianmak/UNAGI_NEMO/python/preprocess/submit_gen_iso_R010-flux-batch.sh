#!/bin/bash
#FLUX: --job-name=tart-lettuce-3374
#FLUX: --priority=16

export data_dir='/scratch/PI/jclmak/data/users/julian/NEMO/UNAGI/nemo4.0.5/EXP_R010/split_200km/alp0060_lam80/tau100x/ANALYSIS/'

module load openmpi3
python --version
which mpirun
source /opt/ohpc/pub/apps/anaconda3/bin/activate
source /opt/ohpc/pub/apps/anaconda3/bin/activate py38
python --version
which mpirun
echo " _ __   ___ _ __ ___   ___         "
echo "| '_ \ / _ \ '_ ' _ \ / _ \        "
echo "| | | |  __/ | | | | | (_) |       "
echo "|_| |_|\___|_| |_| |_|\___/  v3.7  "
echo "OK: ...and here is Christopher doing some calculations for you......"
echo "                  ,-.____,-.          "
echo "                  /   ..   \          "
echo "                 /_        _\         "
echo "                |'o'      'o'|        "
echo "               / ____________ \       "
echo "             , ,'    '--'    '. .     "
echo "            _| |              | |_    "
echo "          /  ' '              ' '  \  "
echo "         (    ',',__________.','    ) "
echo "          \_    ' ._______, '     _/  "
echo "             |                  |     "
echo "             |    ,-.    ,-.    |     "
echo "              \      ).,(      /      "
echo "         gpyy   \___/    \___/        "
export data_dir=/scratch/PI/jclmak/data/users/julian/NEMO/UNAGI/nemo4.0.5/EXP_R010/split_200km/alp0060_lam80/tau100x/ANALYSIS/
/opt/ohpc/pub/mpi/openmpi3-gnu8/3.1.4/bin/mpirun -n 1 python gen_isodeps_tave.py ${data_dir} "*MOC_T*"
wait
sbatch submit_gen_energy_R010
echo "Done!"
