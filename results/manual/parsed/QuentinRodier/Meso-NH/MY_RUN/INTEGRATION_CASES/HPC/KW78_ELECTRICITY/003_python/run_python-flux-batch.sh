#!/bin/bash
#FLUX: --job-name=tools
#FLUX: -t=3600
#FLUX: --urgency=16

ulimit -c 0
ulimit -s unlimited
set -e
module purge
module load python/3.10.12
ln -sf ${SRC_MESONH}/src/LIB/Python/*.py .
python3 plot_flash.py IC3E4
python3 plot_CV_elec_MNH.py IC3E4 001
python3 plot_CV_elec_MNH.py IC3E4 002
python3 plot_CV_elec_MNH.py IC3E4 003
python3 plot_CV_elec_MNH.py IC3E4 004
python3 plot_CV_elec_MNH.py IC3E4 005
python3 plot_CV_elec_MNH.py IC3E4 006
convert Fig_*IC3E4*.png ice3.pdf
python3 plot_flash.py LI1E4
python3 plot_CV_elec_MNH.py LI1E4 001
python3 plot_CV_elec_MNH.py LI1E4 002
python3 plot_CV_elec_MNH.py LI1E4 003
python3 plot_CV_elec_MNH.py LI1E4 004
python3 plot_CV_elec_MNH.py LI1E4 005
python3 plot_CV_elec_MNH.py LI1E4 006
convert Fig_*LI1E4*.png lima.pdf
python3 plot_flash.py LI2E4
python3 plot_CV_elec_MNH.py LI2E4 001
python3 plot_CV_elec_MNH.py LI2E4 002
python3 plot_CV_elec_MNH.py LI2E4 003
python3 plot_CV_elec_MNH.py LI2E4 004
python3 plot_CV_elec_MNH.py LI2E4 005
python3 plot_CV_elec_MNH.py LI2E4 006
convert Fig_*LI2E4*.png lima2.pdf
python3 plot_flash.py IC3E3
python3 plot_CV_elec_MNH.py IC3E3 001
python3 plot_CV_elec_MNH.py IC3E3 002
python3 plot_CV_elec_MNH.py IC3E3 003
python3 plot_CV_elec_MNH.py IC3E3 004
python3 plot_CV_elec_MNH.py IC3E3 005
python3 plot_CV_elec_MNH.py IC3E3 006
convert Fig_*IC3E3*.png old.pdf
