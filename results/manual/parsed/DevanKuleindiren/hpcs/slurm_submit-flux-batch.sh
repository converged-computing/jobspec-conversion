#!/bin/bash
#FLUX: --job-name=ornery-onion-8457
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/lib:$CUDA_INSTALL_PATH/lib64;'

cluster_type=$1;
script_path=$2;
shift;
shift;
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
if [ $cluster_type == "cpu" ]; then
	module load default-impi                 # REQUIRED - loads the basic environment
	#module load default-impi-LATEST
elif [ $cluster_type == "gpu" ]; then
	module load default-wilkes
else
	echo "Need to choose cluster type";
        exit;
fi;
module load gcc/4.8.1
module load git/2.0.0
module swap cuda cuda/8.0
module load cudnn/5.1_cuda-8.0
module load python/2.7.10
if [ $cluster_type == "cpu" ]; then
	source /home/dk503/.venv/tensorflow_cpu/bin/activate;
elif [ $cluster_type == "gpu" ]; then
	source /home/dk503/.venv/tensorflow/bin/activate;
fi;
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
cd $workdir
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:$CUDA_INSTALL_PATH/lib64;
i=0;
for configfile in "$@"; do
	configprefix="${configfile%.*}"
	configargs=$(cat $configfile)
	echo "srun --exclusive -N1 -n1 python -u $script_path $configargs > $configprefix.log 2> $configprefix.err &"
	srun --exclusive -N1 -n1 python -u $script_path $configargs > $configprefix.log 2> $configprefix.err &
	i=$(($i + 1));
done;
wait;
