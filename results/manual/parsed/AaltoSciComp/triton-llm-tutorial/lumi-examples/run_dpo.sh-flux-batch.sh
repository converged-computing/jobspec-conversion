#!/bin/bash
#FLUX: --job-name=dpoExample
#FLUX: --exclusive
#FLUX: --queue=standard-g
#FLUX: -t=3600
#FLUX: --urgency=16

export PYTHONPATH='/workdir/env_dpo/lib/python3.10/site-packages'
export HF_HOME='/workdir/'
export HF_TOKEN='yourtoken'
export TRANSFORMERS_OFFLINE='1'
export HF_DATASETS_OFFLINE='1'

wd=$(realpath .)
SIF=lumi-pytorch-rocm-5.6.1-python-3.10-pytorch-v2.1.0.sif
rm -rf $wd/run-me.sh
cat > $wd/run-me.sh << EOF
echo "Rank \$SLURM_PROCID - \$(taskset -p \$\$) \$ROCR_VISIBLE_DEVICES"
if [ \$SLURM_LOCALID -eq 0 ] ; then
    rocm-smi 
fi
sleep 2
\$WITH_CONDA
export PYTHONPATH=/workdir/env_dpo/lib/python3.10/site-packages
export HF_HOME=/workdir/
export HF_TOKEN=yourtoken
export TRANSFORMERS_OFFLINE=1
export HF_DATASETS_OFFLINE=1
set -x
python /workdir/rlhf_dpo_multi_gpu.py
EOF
chmod +x $wd/run-me.sh
singularity exec \
        -B "$wd:/workdir" \
         $SIF /workdir/run-me.sh
