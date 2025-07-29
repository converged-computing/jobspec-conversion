#!/bin/bash
#SBATCH --job-name=20210601
#SBATCH --output=/mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/logs/my_job_mpas.o%j
#SBATCH --error=/mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/logs/my_job_mpas.e%j
#SBATCH --nodes=8
#SBATCH --ntasks=1024
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00

export executable='atmosphere_model'
export PMIX_MCA_gds='hash'

export executable=atmosphere_model
export PMIX_MCA_gds=hash
. /home/julio.fernandez/.spack/gnu/env.sh
spack load --only dependencies mpas-model%gcc@9.4.0
spack load --list
ulimit -s unlimited
cd /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100
echo $SLURM_JOB_NUM_NODES
echo  "STARTING AT `date` "
Start=`date +%s.%N`
echo $Start >  /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/Timing
time mpirun -np $SLURM_NTASKS ./${executable}
End=`date +%s.%N`
echo  "FINISHED AT `date` "
echo $End   >> /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/Timing
echo $Start $End | awk '{print $2 - $1" sec"}' >>  /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/Timing
mv log.atmosphere.*.out /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/logs
mv namelist.atmosphere /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/scripts
mv mpas_exe.sh /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/scripts
mv stream* /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/scripts
mv x1.*.init.nc* /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/mpasprd
mv diag* /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/mpasprd
mv histor* /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/mpasprd
mv Timing /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/logs/Timing.MPAS
find /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100 -maxdepth 1 -type l -exec rm -f {} \;
exit 0
