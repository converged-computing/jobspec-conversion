#!/bin/bash
#SBATCH --account=BCS20003
#SBATCH --output=job-%x-%A.out
#SBATCH --error=job-%x-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00

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
PARENT="/work/09874/tliangwi/ls6/"
cd "${PARENT}/gns"
source "venv/bin/activate"
SET_PATH="${PARENT}data_chrono/"
python -u -m gns.train --data_path="${SET_PATH}datasets/" --model_path="${SET_PATH}models/" --con_radius=0.025 --ntraining_steps=2000000
