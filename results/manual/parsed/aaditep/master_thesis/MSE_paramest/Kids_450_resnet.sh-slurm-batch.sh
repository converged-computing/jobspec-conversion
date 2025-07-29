#!/bin/bash
#SBATCH --job-name=gpu_test1
#SBATCH --output=gpu_24gb.out
#SBATCH --error=gpu_24gb.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=60
#SBATCH --gres=gpumem:24gb
#SBATCH --mem=2g
#SBATCH --time=12:00:00

echo "Transfering files to local scratch"
start_time=$(date +%s)
mkdir ${TMPDIR}/kids_450_h5_files
rsync -aq /cluster/work/refregier/atepper/kids_450/small_sample/kids_450_h5 ${TMPDIR}/kids_450_h5_files/
end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
echo "Elapsed time: $elapsed_time seconds"
module purge
module load gcc/8.2.0 python_gpu/3.10.4
module load eth_proxy
source $HOME/thesis_env3/bin/activate
python Kids_450_resnet.py --config ./data/configs/config_Kids_450_resnet_2.yaml
