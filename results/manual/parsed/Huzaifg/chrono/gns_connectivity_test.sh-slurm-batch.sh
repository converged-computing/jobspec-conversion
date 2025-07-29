#!/bin/bash
#SBATCH --account=BCS20003
#SBATCH --output=job-%x-%A.out
#SBATCH --error=job-%x-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu-h100

export LD_LIBRARY_PATH='/usr/lib64:$LD_LIBRARY_PATH'

ml cuda/12.0
ml cudnn
ml nccl
module load intel/19.1.1
module load impi/19.0.9
module load mvapich2-gdr/2.3.7
module load mvapich2/2.3.7
module load phdf5/1.10.4
module load python3/3.9.7
export LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH
PARENT="/work/09874/tliangwi/terrainmodel/"
source "${PARENT}/gns/venv/bin/activate"
cd "${PARENT}/gns"
DATA_PATH="${PARENT}data/dataset_955_20_std-vel_correct/"
MODEL_PATH="${PARENT}data/models_conn_test/"
for i in $(seq 0.005 0.005 0.035)
do
	echo "CONNECTIVITY RADIUS: ${i}"
	python -u -m gns.train --data_path=${DATA_PATH} --model_path=${MODEL_PATH} --con_radius=${i} --ntraining_steps=1000 &
	PY_PID=$!
	wait $PY_PID
	echo "#"
done
