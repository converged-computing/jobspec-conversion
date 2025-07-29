#!/bin/bash
#SBATCH --job-name=<simulation_name>
#SBATCH --account=<project_id>
#SBATCH --output=<simulation_name>.o%j
#SBATCH --error=<simulation_name>.e%j
#SBATCH --mail-user=<email_address>
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

module load LUMI/23.09 partition/C EasyBuild-user
module load OpenFOAM/v2312-cpeGNU-23.09
source $EBROOTOPENFOAM/etc/bashrc WM_COMPILER=Cray WM_MPLIB=CRAY-MPICH
blockMesh
decomposePar
srun pisoFoam -parallel
