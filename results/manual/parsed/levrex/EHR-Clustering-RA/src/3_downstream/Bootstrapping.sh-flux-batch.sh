#!/bin/bash
#FLUX: --job-name=Bootstrapping
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module add library/cuda/11.2/gcc.8.3.1
module load tools/miniconda/python3.8/4.9.2
echo "Starting at `date`"
echo "Running on hosts: $SLURM_JOB_NODELIST"
echo "Running on $SLURM_JOB_NUM_NODES nodes."
echo "Running $SLURM_NTASKS tasks."
echo "Account: $SLURM_JOB_ACCOUNT"
echo "Job ID: $SLURM_JOB_ID"
echo "Job name: $SLURM_JOB_NAME"
echo "Node running script: $SLURMD_NODENAME"
echo "Submit host: $SLURM_SUBMIT_HOST"
echo "Current working directory is `pwd`"
conda activate ../convae_architecture/envs
python src/3_downstream/Bootstrapping_OnlyNumeric.py #  Bootstrapping_OnlyCategoric.py # _OnlyNumeric
echo "Program finished with exit code $? at: `date`"
