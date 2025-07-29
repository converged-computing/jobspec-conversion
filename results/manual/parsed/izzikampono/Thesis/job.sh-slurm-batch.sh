#!/bin/bash
#SBATCH --job-name=python_cpu
#SBATCH --output=output.log
#SBATCH --error=error_file_jobsh.txt
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=40G
#SBATCH --time=00:10:00

module purge
module load Python/3.9.6-GCCcore-11.2.0
if [ $# -lt 3 ]; then
    echo "Usage: $0 <problem> [<horizon>] [num_iter]"
    exit 1
fi
source /scratch/s3918343/venvs/thesis/bin/activate
pip install --upgrade pip
pip install --upgrade wheel
pip install -r requirements.txt
echo "problem : $1 , horizon: $2, iter : $3"
cd /scratch/s3918343/venvs/thesis/Thesis
python experiment.py problem=$1 horizon=$2 iter=$3
echo "DONE"
deactivate
