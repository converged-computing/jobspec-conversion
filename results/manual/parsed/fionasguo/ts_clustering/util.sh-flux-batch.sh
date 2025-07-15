#!/bin/bash
#FLUX: --job-name=eccentric-rabbit-5903
#FLUX: -c=40
#FLUX: --queue=long
#FLUX: -t=259200
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/nas/home/siyiguo/anaconda3/lib'

source ~/anaconda3/envs/damf_env/bin/activate ts_embed
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/nas/home/siyiguo/anaconda3/lib
python setup.py install
pip install pandas==1.4
python src/real_test_data_processing/process_rvw_data.py
pip install pandas==2.1.1
