#!/bin/bash
#SBATCH --account=BCS20003
#SBATCH --output=job-%x-%A.out
#SBATCH --error=job-%x-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu-a100-small

export LD_LIBRARY_PATH='/usr/lib64:$LD_LIBRARY_PATH'

module load intel/19.1.1
module load impi/19.0.9
module load mvapich2-gdr/2.3.7
module load mvapich2/2.3.7
module load phdf5/1.10.4
module load python3/3.9.7
export LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH
PARENT="/work/09874/tliangwi/ls6/"
source "${PARENT}/gns/venv/bin/activate"
pip install pandas
cd $PARENT/chrono
python -u chrono_npz.py 197 sph_data
