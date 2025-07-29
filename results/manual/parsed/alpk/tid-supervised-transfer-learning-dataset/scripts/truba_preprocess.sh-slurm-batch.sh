#!/bin/bash
#FLUX: --job-name=run_preprocess
#FLUX: -c=4
#FLUX: --queue=mid2
#FLUX: -t=14400
#FLUX: --urgency=16

module load centos7.3/lib/cuda/10.1
module load centos7.3/comp/gcc/6.4
/truba/home/akindiroglu/Workspace/Libs/pytorch_nightly/bin/python generate_csv_files.py
