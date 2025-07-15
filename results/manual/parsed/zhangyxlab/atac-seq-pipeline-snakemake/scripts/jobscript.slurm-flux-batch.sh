#!/bin/bash
#FLUX: --job-name=hanky-truffle-3606
#FLUX: --priority=16

export PATH=':$PATH:/storage/zhangyanxiaoLab/share/bin'

module load picard
module load R
module load bowtie
module load samtools
unset PYTHONPATH
source /storage/zhangyanxiaoLab/share/Pipelines/environments/python3env/bin/activate
export PATH=:$PATH:/storage/zhangyanxiaoLab/share/bin
{exec_job}
