#!/bin/bash
#FLUX: --job-name=dr_benchmark_small
#FLUX: -c=4
#FLUX: --queue=magic
#FLUX: -t=120000
#FLUX: --urgency=16

line=$(sed -n ${SLURM_ARRAY_TASK_ID}p < ./slurm_test/parameters.csv)
rec_column1=$(cut -d',' -f1 <<< "$line")
rec_column2=$(cut -d',' -f2 <<< "$line")
if [ ! -f "$rec_column1" ]; then
  echo python3 $rec_column2
  srun --container-image=./python-ml-15-02.sqsh --container-name=python-ml_batch27 --container-mounts=/hpi/fs00/share/fg-doellner/tim.cech/slurm_test:/home/tim.cech/slurm_test --container-workdir=/home/tim.cech/slurm_test python3 $rec_column2
fi
