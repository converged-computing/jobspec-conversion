#!/bin/bash
#SBATCH --account=long
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=1
#SBATCH --mem=0
#SBATCH --time=3-00:00:00

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/nas/home/siyiguo/anaconda3/lib'

source ~/anaconda3/envs/damf_env/bin/activate ts_embed
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/nas/home/siyiguo/anaconda3/lib
python setup.py install
pip install pandas==1.4
python src/real_test_data_processing/process_rvw_data.py
pip install pandas==2.1.1
