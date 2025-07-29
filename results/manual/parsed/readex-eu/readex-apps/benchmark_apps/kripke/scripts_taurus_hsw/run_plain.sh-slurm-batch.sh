#!/bin/bash
#SBATCH --account=p_readex
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=60000
#SBATCH --time=00:30:00
#SBATCH --exclusive

cd ../build
. ../readex_env/set_env_plain.source
. ../environment.sh
stopHdeem
clearHdeem
startHdeem
sleep 1
stopHdeem
echo "running kripke"
clearHdeem
startHdeem
srun -n 24 ./kripke $KRIPKE_COMMAND
stopHdeem
sleep 1
checkHdeem
echo "running kripke done"
