#!/bin/bash
#SBATCH --job-name=kripke
#SBATCH --account=p_readex
#SBATCH --mail-user=ondrej.vysocky@vsb.cz
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2500M
#SBATCH --time=1-00:12:00
#SBATCH --exclusive

export MERIC_MODE='2'
export MERIC_COUNTERS='papi'
export MERIC_CONTINUAL='1'
export MERIC_DETAILED='1'
export MERIC_OUTPUT_DIR='$SCRATCH/KRIPKE'
export MERIC_FREQUENCY='25'
export MERIC_UNCORE_FREQUENCY='25'
export MERIC_NUM_THREADS='0'
export MERIC_OUTPUT_FILENAME='$MERIC_FREQUENCY"_"$MERIC_UNCORE_FREQUENCY"_CONFIG'

hostname
cd ../build
. ../readex_env/set_env_meric.source
. ../environment.sh
export MERIC_MODE=2
export MERIC_COUNTERS=papi
export MERIC_CONTINUAL=1
export MERIC_DETAILED=1
export MERIC_OUTPUT_DIR=$SCRATCH/DELETE
export MERIC_FREQUENCY=25
export MERIC_UNCORE_FREQUENCY=25
export MERIC_NUM_THREADS=0
export MERIC_OUTPUT_FILENAME=$MERIC_FREQUENCY"_"$MERIC_UNCORE_FREQUENCY"_CONFIG"
srun -n 24 ./kripke $KRIPKE_COMMAND
export MERIC_OUTPUT_DIR=$SCRATCH/KRIPKE
for proc in 24
do
	for thread in 0
	do
		for cpu_freq in 25 {24..12..2} 
		do
			for uncore_freq in {30..12..2} 
			do
				# OUTPUT NAMES
				export MERIC_OUTPUT_FILENAME=$cpu_freq"_"$uncore_freq"_CONFIG"
				# TEST SETTINGS
				export MERIC_FREQUENCY=$cpu_freq
				export MERIC_UNCORE_FREQUENCY=$uncore_freq
				echo "Output file: "  $MERIC_OUTPUT_FILENAME
				echo 
				srun -n 24 ./kripke $KRIPKE_COMMAND | tee -a LOGmeric
			done
		done
	done
done
