#!/bin/bash
#FLUX: --job-name=crusty-latke-1923
#FLUX: --queue=hgx2q
#FLUX: -t=10
#FLUX: --urgency=16

export OMPI_MCA_opal_cuda_support='true'

ulimit -s 10240
module load slurm/20.02.7
module load cuda11.2/toolkit/11.2.2
module load openmpi4-cuda11.2-ofed50-gcc8/4.1.0
mkdir -p output_hgx/$NOW
mkdir -p /work/$USER/$SLURM_JOB_ID/ShallowWaterGPU
cp -r . /work/$USER/$SLURM_JOB_ID/ShallowWaterGPU
cd /work/$USER/$SLURM_JOB_ID/ShallowWaterGPU
export OMPI_MCA_opal_cuda_support=true
mpirun -np $SLURM_NTASKS $HOME/miniconda3/envs/ShallowWaterGPU_HPC/bin/python3 mpiTesting.py -nx $NX -ny $NY --profile
cd $HOME/src/ShallowWaterGPU
mkdir -p output_hgx/$NOW/$SLURM_JOB_ID
mv /work/$USER/$SLURM_JOB_ID/ShallowWaterGPU/*.log ./output_hgx/$NOW/$SLURM_JOB_ID
mv /work/$USER/$SLURM_JOB_ID/ShallowWaterGPU/*.nc ./output_hgx/$NOW/$SLURM_JOB_ID
mv /work/$USER/$SLURM_JOB_ID/ShallowWaterGPU/*.json ./output_hgx/$NOW
mv /work/$USER/$SLURM_JOB_ID/ShallowWaterGPU/*.qdrep ./output_hgx/$NOW
rm -rf /work/$USER/$SLURM_JOB_ID
