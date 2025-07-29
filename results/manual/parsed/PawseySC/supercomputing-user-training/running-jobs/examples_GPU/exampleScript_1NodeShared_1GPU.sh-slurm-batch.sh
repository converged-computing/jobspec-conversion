#!/bin/bash
#FLUX: --job-name=1GPUSharedNode
#FLUX: --queue=gpu
#FLUX: -t=300
#FLUX: --urgency=16

export OMP_NUM_THREADS='1           #This controls the real CPU-cores per task for the executable'

module load PrgEnv-cray
module load rocm craype-accel-amd-gfx90a
echo -e "\n\n#------------------------#"
module list
echo -e "\n\n#------------------------#"
echo "Printing from scontrol:"
scontrol show job ${SLURM_JOBID}
exeDir=$MYSCRATCH/hello_jobstep
exeName=hello_jobstep
theExe=$exeDir/$exeName
export OMP_NUM_THREADS=1           #This controls the real CPU-cores per task for the executable
echo -e "\n\n#------------------------#"
echo "Test code execution:"
srun -l -u -N 1 -n 1 -c 8 --gpus-per-node=1 --gpus-per-task=1 ${theExe} | sort -n
echo -e "\n\n#------------------------#"
echo "Printing information of finished jobs steps using sacct:"
sacct -j ${SLURM_JOBID} -o jobid%20,Start%20,elapsed%20
echo -e "\n\n#------------------------#"
echo "Done"
