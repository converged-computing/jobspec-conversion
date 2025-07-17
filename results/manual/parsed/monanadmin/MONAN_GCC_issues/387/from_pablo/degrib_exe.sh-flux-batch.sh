#!/bin/bash
#FLUX: --job-name=gfs4mpas
#FLUX: --queue=batch
#FLUX: -t=1800
#FLUX: --urgency=16

export PMIX_MCA_gds='hash'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/home/julio.fernandez/local/lib64'

ulimit -s unlimited
ulimit -c unlimited
ulimit -v unlimited
export PMIX_MCA_gds=hash
echo  "STARTING AT `date` "
Start=`date +%s.%N`
echo $Start > Timing.degrib
. /home/julio.fernandez/.spack/gnu/env.sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/julio.fernandez/local/lib64
spack load --only dependencies mpas-model%gcc@9.4.0
spack load --list
ldd ungrib.exe
cd /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/wpsprd
if [ -e namelist.wps ]; then rm -f namelist.wps; fi
rm -f GRIBFILE.* namelist.wps
sed -e "s,#LABELI#,2021-06-01_00:00:00,g;s,#PREFIX#,GFS2,g" 	/mnt/beegfs/julio.fernandez/MPAS/testcase/namelist/namelist.wps.TEMPLATE > ./namelist.wps
./link_grib.csh gfs.t00z.pgrb2.0p25.f000.*.grib2
mpirun -np 1 ./ungrib.exe
echo 2021-06-01_00
rm -f GRIBFILE.*
End=`date +%s.%N`
echo  "FINISHED AT `date` "
echo $End   >>Timing.degrib
echo $Start $End | awk '{print $2 - $1" sec"}' >> Timing.degrib
grep "Successful completion of program ungrib.exe" ungrib.log >& /dev/null
if [ $? -ne 0 ]; then
   echo "  BUMMER: Ungrib generation failed for some yet unknown reason."
   echo " "
   tail -10 /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/logs/ungrib.log
   echo " "
   exit 21
fi
   echo "  ####################################"
   echo "  ### Ungrib completed - $(date) ####"
   echo "  ####################################"
   echo " " 
   mv ungrib.*.log /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/logs
   mv ungrib.log /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/logs/ungrib.2021-06-01_00:00:00.log
   mv Timing.degrib /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/logs
   mv namelist.wps degrib_exe.sh /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/scripts
   rm -f link_grib.csh
   cd ..
   ln -sf wpsprd/GFS2\:2021-06-01_00 .
   find /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/wpsprd -maxdepth 1 -type l -exec rm -f {} \;
echo "End of degrib Job"
exit 0
