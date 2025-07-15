#!/bin/bash
#FLUX: --job-name=Hills_demultiplex
#FLUX: --queue=short
#FLUX: -t=32400
#FLUX: --urgency=16

cd /projects/bgmp/mhills/demultiplex
module purge
module load easybuild intel/2017a Python/3.6.1 icc/2017.1.132-GCC-6.3.0-2.27 impi/2017.1.132 ifort/2017.1.132-GCC-6.3.0-2.27 impi/2017.1.132 matplotlib/2.0.1-Python-3.6.1 
python demulti.py
