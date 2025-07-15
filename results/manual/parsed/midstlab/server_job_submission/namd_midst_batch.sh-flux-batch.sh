#!/bin/bash
#FLUX: --job-name=1fcc_MuMi
#FLUX: -N=2
#FLUX: --queue=midst
#FLUX: -t=1296000
#FLUX: --priority=16

INPUT_FILE="1pga_autopsf_wb_ionized_config.conf"
source /etc/profile.d/modules.sh
echo "source /etc/profile.d/modules.sh"
echo "Loading NAMD..."
module load namd/2.13/multicore
echo
echo
echo "============================== ENVIRONMENT VARIABLES ==============================="
env
echo "===================================================================================="
echo
echo
echo "=================================== STACK SIZE ====================================="
ulimit -s unlimited
ulimit -l unlimited
ulimit -a
echo "===================================================================================="
echo
chmod +x config_joblist
./config_joblist
