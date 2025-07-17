#!/bin/bash
#FLUX: --job-name=md1
#FLUX: --gpus-per-task=1
#FLUX: --queue=3090
#FLUX: --urgency=16

export PATH='/data/home/wuxingxing/codespace/lammps_nep/src:$PATH'
export PYTHONPATH='/data/home/wuxingxing/codespace/PWMLFF_nep/src/:$PYTHONPATH'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$(python3 -c "import torch; print(torch.__path__[0])")/lib:$(dirname $(dirname $(which python3)))/lib:$(dirname $(dirname $(which PWMLFF)))/op/build/lib'

echo "SLURM_SUBMIT_DIR is $SLURM_SUBMIT_DIR"
echo "Starting job $SLURM_JOB_ID at " `date`
echo "Running on nodes: $SLURM_NODELIST"
start=$(date +%s)
source /data/home/wuxingxing/anaconda3/etc/profile.d/conda.sh
conda activate torch2_feat
export PATH=/data/home/wuxingxing/codespace/PWMLFF_nep/src/bin:$PATH
export PYTHONPATH=/data/home/wuxingxing/codespace/PWMLFF_nep/src/:$PYTHONPATH
export PATH=/data/home/wuxingxing/codespace/lammps_nep/src:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(python3 -c "import torch; print(torch.__path__[0])")/lib:$(dirname $(dirname $(which python3)))/lib:$(dirname $(dirname $(which PWMLFF)))/op/build/lib
module load cuda/11.8
module load intel/2020
mpirun -np 1 lmp_mpi_gpu -in in.lammps
echo "Job $SLURM_JOB_ID done at " `date`
end=$(date +%s)
take=$(( end - start ))
echo Time taken to execute commands is ${take} seconds > tag.md.success
