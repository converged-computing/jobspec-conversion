#!/bin/bash
#FLUX: --job-name=eke50
#FLUX: -n=40
#FLUX: --queue=cpu
#FLUX: -t=259200
#FLUX: --urgency=16

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
for folder in {split_200km,no_split}; do
  /opt/ohpc/pub/mpi/openmpi3-gnu8/3.1.4/bin/mpirun -n 1 python gen_ekezint_tave.py /scratch/PI/jclmak/data/users/julian/NEMO/UNAGI/nemo4.0.5/EXP_R050/${folder}/alp0060_lam80/tau100x/ANALYSIS/ "*MOC_U*" "*MOC_V*"
  /opt/ohpc/pub/mpi/openmpi3-gnu8/3.1.4/bin/mpirun -n 1 python gen_epezint_tave.py /scratch/PI/jclmak/data/users/julian/NEMO/UNAGI/nemo4.0.5/EXP_R050/${folder}/alp0060_lam80/tau100x/ANALYSIS/ "*isodep_tave*" --sigma_var "sigma" --file_out "epe_zint_tave_full.nc"
done
wait
echo "Done!"
