#!/bin/bash
#SBATCH --job-name=1fcc_MuMi
#SBATCH --account=midst
#SBATCH --output=%j-log.out
#SBATCH --mail-user=tguclu@sabanciuniv.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=15-00:00:00
#SBATCH --partition=midst
#SBATCH --qos=midst
#SBATCH --constraint=ntasks-per-node=48

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
