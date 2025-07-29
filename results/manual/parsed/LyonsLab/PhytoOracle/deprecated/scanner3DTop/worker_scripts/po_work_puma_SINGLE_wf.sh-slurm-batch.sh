#!/bin/bash
#SBATCH --job-name=phytooracle
#SBATCH --account=windfall
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=windfall
#SBATCH --constraint=ntasks-per-node=94

export CCTOOLS_HOME='/home/u12/cosi/cctools-7.1.6-x86_64-centos7'
export PATH='${CCTOOLS_HOME}/bin:$PATH'

module load python/3.8
export CCTOOLS_HOME=/home/u12/cosi/cctools-7.1.6-x86_64-centos7
export PATH=${CCTOOLS_HOME}/bin:$PATH
/home/u12/cosi/cctools-7.1.6-x86_64-centos7/bin/work_queue_worker -M PhytoOracle_3D -t 900
