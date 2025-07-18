#!/bin/bash
#FLUX: --job-name=cowy-punk-6608
#FLUX: --queue=qgpu
#FLUX: -t=86400
#FLUX: --urgency=16

echo "========= Job started  at `date` =========="
cd $SLURM_SUBMIT_DIR
source /comm/specialstacks/gromacs-volta/bin/modules.sh
module load gromacs-gcc-8.2.0-openmpi-4.0.3-cuda-10.1
gmx_mpi mdrun -s prodrun.tpr -deffnm prodrun -ntomp 18 -maxh 23.9 -cpi prodrun.cpt -v
MAX_RESUB=30
SCRIPT_PATH=$(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}')
JOB_NAME=$(scontrol show job $SLURM_JOBID | awk -F= '/JobName=/{print $3}')
bash /home/thomasen/resubmit.sh $SCRIPT_PATH $MAX_RESUB $JOB_NAME
echo "========= Job finished at `date` =========="
