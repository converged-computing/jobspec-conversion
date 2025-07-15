#!/bin/bash
#FLUX: --job-name=array_test
#FLUX: -c=4
#FLUX: -t=0
#FLUX: --urgency=16

export PATH='/opt/anaconda3/bin:$PATH'
export LD_LIBRARY_PATH='LD_LIBRARY_PATH:/usr/local/cuda-9.0/lib64/'

cd $SLURM_SUBMIT_DIR
export PATH=/usr/local/bin:$PATH
export PATH=/opt/anaconda3/bin:$PATH
export LD_LIBRARY_PATH=LD_LIBRARY_PATH:/usr/local/cuda-9.0/lib64/
conda activate pytorch-build
cmd="/net/pulsar/home/koes/jok120/.conda/envs/pytorch-build/bin/$(sed -n "${PBS_ARRAYID}p" ../research/cluster/191206.txt)"
echo $cmd
eval $cmd
exit 0
