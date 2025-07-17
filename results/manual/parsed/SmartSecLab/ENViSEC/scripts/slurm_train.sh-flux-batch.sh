#!/bin/bash
#FLUX: --job-name=HK-ENViSEC
#FLUX: --queue=dgx2q
#FLUX: -t=259200
#FLUX: --urgency=16

ulimit -s 10240
echo "Job started at:" `date +"%Y-%m-%d %H:%M:%S"`
module purge
module load slurm/20.02.7
module load tensorflow2-py37-cuda10.2-gcc8/2.5.0  
module load python-mpi4py-3.0.3
module list
source venv/bin/activate
which python3
python3 --version
srun sh train.sh
echo "Job ended at:" `date +"%Y-%m-%d %H:%M:%S"`
