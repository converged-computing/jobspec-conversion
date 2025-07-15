#!/bin/bash
#FLUX: --job-name=sticky-taco-1791
#FLUX: --urgency=16

module load anacondapy/5.3.1
source activate lightsheet
echo "In the directory: `pwd` "
echo "As the user: `whoami` "
echo "on host: `hostname` "
cat /proc/$$/status | grep Cpus_allowed_list
python fix_orientation_and_rerun_registration.py
