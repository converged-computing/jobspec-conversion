#!/bin/bash
#FLUX: --job-name=iea15mw_powercurve
#FLUX: -N=40
#FLUX: -t=432000
#FLUX: --urgency=16

export SPACK_MANAGER='/home/gvijayak/exawind/source/spack-manager'

export SPACK_MANAGER=/home/gvijayak/exawind/source/spack-manager
source /home/gvijayak/exawind/source/spack-manager/start.sh
spack-start
quick-activate /home/gvijayak/exawind/source/spack-manager/environments/fsi-merge-release
spack load exawind
cd $(sed -n "${SLURM_ARRAY_TASK_ID}p" case_list)/fsi_run
cp ../openfast_run/IEA*576000* ../openfast_run/*nc ../openfast_run/*IN .
rm -rf out01 rst01 plt* chk*
srun -n 1440 exawind --nwind 720 --awind 720 iea15mw-01.yaml &> log
