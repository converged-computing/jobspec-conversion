#!/bin/bash
#FLUX: --job-name=hairy-bike-4956
#FLUX: -n=13
#FLUX: -t=1800
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'

module load 2021
module load OpenMPI/4.1.1-GCC-10.3.0
module load Python/3.9.5-GCCcore-10.3.0
module load PyTorch-Lightning/1.5.9-foss-2021a-CUDA-11.3.1
export PYTHONUNBUFFERED=1
. venv/bin/activate
cd package || exit
python --version
node_list=($(scontrol show hostnames))
for node in "${node_list[@]}"; do
	echo "Attempting to spawn MPS control daemon on $node"
	ssh $node "nvidia-cuda-mps-control -d"
	ssh $node "echo \"start_server -uid $SLURM_JOB_UID\" | nvidia-cuda-mps-control"
done
echo "Spawned nvidia control daemons"
sleep 2
mpirun python main.py --n_data_reuse 10 --game Hive --model_dir Hive_2 --n_sims 100 --mcts_iterations=150 --playing_batch_size 1
