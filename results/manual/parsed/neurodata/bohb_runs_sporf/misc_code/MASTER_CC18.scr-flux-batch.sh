#!/bin/bash
#FLUX: --job-name=BOHB
#FLUX: --queue=shared,parallel,lrgmem
#FLUX: -t=1800
#FLUX: --priority=16

export SHARE_DIR='test_runs'

export SHARE_DIR=test_runs
if [[ "$USER" == "jpatsol1@jhu.edu" ]]; then
	export NIC=eth4
	export NCORES=$SLURM_NTASKS
	export nJOBS=24
	export nWORKERS=1
	module load python/3.7
	source ~/env/bin/activate
	ml intel/18.0
	dataID=$(awk '{print $1}' tasksCC18_R.dat | sed "$SLURM_ARRAY_TASK_ID q;d")
elif [[ "$USER" == "JLP" ]]; then
	export NIC=en0
	export nJOBS=1
	export nWORKERS=1
	#export dataID=$1
	export dataID=$(awk '{print $1}' tasksCC18_R.dat | sed "1 q;d")
	export SHARE_DIR=test_runs
fi
python bohb_run.py --nic_name $NIC --n_jobs $nJOBS --n_workers $nWORKERS --openml_dataid $dataID --run_id $dataID --shared_directory $SHARE_DIR
