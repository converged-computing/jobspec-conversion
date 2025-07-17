#!/bin/bash
#FLUX: --job-name=3GPUSharedNode-bindMethod1
#FLUX: --queue=gpu
#FLUX: -t=300
#FLUX: --urgency=16

export MPICH_GPU_SUPPORT_ENABLED='1 #This allows for GPU-aware MPI communication among GPUs'
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
export MPICH_GPU_SUPPORT_ENABLED=1 #This allows for GPU-aware MPI communication among GPUs
export OMP_NUM_THREADS=1           #This controls the real CPU-cores per task for the executable
echo -e "\n\n#------------------------#"
echo "Test code execution:"
srun -l -u -N 1 -n 3 -c 8 --gpus-per-node=3 --gpus-per-task=1 --gpu-bind=closest ${theExe} | sort -n
echo -e "\n\n#------------------------#"
echo "Printing information of finished jobs steps using sacct:"
sacct -j ${SLURM_JOBID} -o jobid%20,Start%20,elapsed%20
echo -e "\n\n#------------------------#"
echo "Done"
