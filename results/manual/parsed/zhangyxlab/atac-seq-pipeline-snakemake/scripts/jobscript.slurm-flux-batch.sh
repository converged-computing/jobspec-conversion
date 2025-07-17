#!/bin/bash
#FLUX: --job-name=ATACseq
#FLUX: --queue=amd-ep2
#FLUX: --urgency=16

export PATH=':$PATH:/storage/zhangyanxiaoLab/share/bin'

module load picard
module load R
module load bowtie
module load samtools
unset PYTHONPATH
source /storage/zhangyanxiaoLab/share/Pipelines/environments/python3env/bin/activate
export PATH=:$PATH:/storage/zhangyanxiaoLab/share/bin
{exec_job}
