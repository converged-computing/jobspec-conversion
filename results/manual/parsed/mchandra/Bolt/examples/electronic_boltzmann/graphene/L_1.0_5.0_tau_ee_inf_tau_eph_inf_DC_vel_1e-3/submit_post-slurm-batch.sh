#!/bin/bash
#SBATCH --account=w19_mcpgpu
#SBATCH --output=out_%j
#SBATCH --error=err_%j
#SBATCH --mail-user=mc0710@gmail.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=8
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --time=16:00:00
#SBATCH --qos=standard

export AF_PATH='/usr/projects/p18_ebhlight3d/arrayfire/arrayfire_install          '
export PETSC_DIR='/usr/projects/p18_ebhlight3d/petsc_3.10.0_install               '
export LD_LIBRARY_PATH='$AF_PATH/lib64:$LD_LIBRARY_PATH                           '
export PYTHONPATH='$PYTHONPATH:/users/manic/bolt_master'

                          # See https://hpc.lanl.gov/scheduling_policies         
module list                                                                      
pwd                                                                              
date                                                                             
export AF_PATH=/usr/projects/p18_ebhlight3d/arrayfire/arrayfire_install          
export PETSC_DIR=/usr/projects/p18_ebhlight3d/petsc_3.10.0_install               
export LD_LIBRARY_PATH=$AF_PATH/lib64:$LD_LIBRARY_PATH                           
export PYTHONPATH=$PYTHONPATH:/users/manic/bolt_master
source activate /usr/projects/p18_ebhlight3d/bolt_env_2019.1/                    
srun python main.py
