#!/bin/bash
#FLUX: --job-name=gassy-nunchucks-6571
#FLUX: --queue=gpu
#FLUX: -t=18000
#FLUX: --urgency=16

module load python/3.5.2
pip install tensorflow-gpu==1.4.1 --user
pip install keras --user
pip install tqdm --user
module load cuda/8.0.44
module load cudnn/8.0-v6.0
module load gcc/4.9.2
ssh -o StrictHostKeyChecking=no -f -N -p 22 -R 5255:localhost:5255 int3
jupyter notebook --no-browser --port 5255 --NotebookApp.token=''
