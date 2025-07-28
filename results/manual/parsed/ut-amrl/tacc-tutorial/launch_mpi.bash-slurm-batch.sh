#!/bin/bash
#FLUX: --job-name=mpi-test
#FLUX: -N=2
#FLUX: -n=32
#FLUX: --queue=gpu-a100
#FLUX: -t=900
#FLUX: --urgency=16

module load python3
module load cuda/12.0
module load tacc-apptainer
ibrun -n 16 -o  0 task_affinity singularity exec --nv tacc-tutorial.sif python test_mpi.py --job_id 0 > output/job0.txt &   
ibrun -n 16 -o 16 task_affinity singularity exec --nv tacc-tutorial.sif python test_mpi.py --job_id 1 >  output/job1.txt & 
wait
