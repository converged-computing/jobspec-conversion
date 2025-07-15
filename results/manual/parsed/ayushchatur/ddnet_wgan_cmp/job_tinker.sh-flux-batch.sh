#!/bin/bash
#FLUX: --job-name=WGAN
#FLUX: -c=48
#FLUX: --queue=dgx_normal_q
#FLUX: -t=165600
#FLUX: --priority=16

export MASTER_PORT='8888'
export weight_path='./$SLURM_JOBID/'
export imagefile='/projects/synergy_lab/ayush/containers/pytorch_23.03.sif'
export BASE='apptainer  exec --nv --writable-tmpfs --bind=/projects/synergy_lab,/cm/shared,${TMPFS} ${imagefile} '
export conda_env='test'
export CMD='python3 main.py --save_path $weight_path'

export MASTER_PORT=8888
echo "NODELIST="${SLURM_NODELIST}
if [ ${SLURM_NODELIST:6:1} == "[" ]; then
    echo "MASTER_ADDR="${SLURM_NODELIST:0:6}${SLURM_NODELIST:7:3}
module reset
    export MASTER_ADDR=${SLURM_NODELIST:0:6}${SLURM_NODELIST:7:3}
else
    echo "MASTER_ADDR="${SLURM_NODELIST}
    export MASTER_ADDR=${SLURM_NODELIST}
fi
mkdir -p $SLURM_JOBID
export weight_path="./$SLURM_JOBID/"
module reset
module restore cu117
module list
module load containers/apptainer
source ~/.bashrc
conda activate test
export imagefile="/projects/synergy_lab/ayush/containers/pytorch_23.03.sif"
export BASE="apptainer  exec --nv --writable-tmpfs --bind=/projects/synergy_lab,/cm/shared,${TMPFS} ${imagefile} "
export conda_env="test"
export CMD="python3 main.py --save_path $weight_path"
echo "running command with srun: $BASE $CMD"
srun  --unbuffered --wait=120 --kill-on-bad-exit=0 --cpu-bind=none $CMD
