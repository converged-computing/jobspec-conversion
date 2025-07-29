#!/bin/bash
#SBATCH --job-name=openmm_cg_cuda
#SBATCH --output=/scratch/job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla:1
#SBATCH --partition=gpu
#SBATCH --exclude=gpu-dy-p38xlarge-1,gpu-dy-p38xlarge-2

whoami
id -a
docker run --rm --runtime=nvidia -v $(dirname `pwd`):$(dirname `pwd`) -w `pwd` bmset/gromacs_openmm:latest bash ../run_martinize.sh
docker run --rm --runtime=nvidia -v $(dirname `pwd`):$(dirname `pwd`) -w `pwd` bmset/gromacs_openmm:latest python ../generate_gro_file.py
docker run --rm --runtime=nvidia -v $(dirname `pwd`):$(dirname `pwd`) -w `pwd` bmset/gromacs_openmm:latest bash ../create_simulation.sh 2 20
docker run --rm --runtime=nvidia -v $(dirname `pwd`):$(dirname `pwd`) -w `pwd` bmset/gromacs_openmm:latest python ../run_CG_simulation.py
