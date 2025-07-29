#!/bin/bash
#SBATCH --job-name=san_tune
#SBATCH --output=san_tune.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=8
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

cd $SLURM_SUBMIT_DIR
module load lang/python/anaconda/3.9.7-2021.12-tensorflow.2.7.0
source /user/work/ez18285/spivenv/bin/activate
host=$(hostname | cut -d '.' -f 1)
ip=$(hostname -i)
suffix='6379'
ip_head=${ip}:${suffix}
export ip_head
let "worker_num=(${SLURM_NTASKS} - 1)"
let "total_cores=${worker_num} * ${SLURM_CPUS_PER_TASK}"
echo "Stopping any residual ray components..."
ray stop || true
sleep 5
./tunehead.sh ${host}
./tuneworker.sh ${worker_num} ${host}
python optimise_sanv2.py $ip_head $1
echo "Stopping ray cluster."
ray stop
