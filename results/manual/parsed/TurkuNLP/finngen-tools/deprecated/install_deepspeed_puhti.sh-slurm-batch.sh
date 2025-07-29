#!/bin/bash
#SBATCH --account=project_2004600
#SBATCH --output=logs/%j.out
#SBATCH --error=logs/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1,nvme:100
#SBATCH --mem=8G
#SBATCH --time=00:15:00
#SBATCH --partition=gputest

export DS_BUILD_CPU_ADAM='1'
export DS_BUILD_FUSED_ADAM='1'
export DS_BUILD_FUSED_LAMB='1'
export DS_BUILD_SPARSE_ATTN='1'
export DS_BUILD_TRANSFORMER='1'
export DS_BUILD_TRANSFORMER_INFERENCE='0 # compile fails'
export DS_BUILD_STOCHASTIC_TRANSFORMER='1'
export DS_BUILD_UTILS='1'
export DS_BUILD_AIO='0 # no libaio'

export DS_BUILD_CPU_ADAM=1
export DS_BUILD_FUSED_ADAM=1
export DS_BUILD_FUSED_LAMB=1
export DS_BUILD_SPARSE_ATTN=1
export DS_BUILD_TRANSFORMER=1
export DS_BUILD_TRANSFORMER_INFERENCE=0 # compile fails
export DS_BUILD_STOCHASTIC_TRANSFORMER=1
export DS_BUILD_UTILS=1
export DS_BUILD_AIO=0 # no libaio
rm -f logs/latest.out logs/latest.err
ln -s $SLURM_JOBID.out logs/latest.out
ln -s $SLURM_JOBID.err logs/latest.err
module purge
module load gcc/9.1.0 cuda/11.1.0 pytorch/1.9
python -m pip uninstall --yes deepspeed
python -m pip install --user deepspeed --global-option="build_ext"
python -m deepspeed.env_report
