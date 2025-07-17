#!/bin/bash
#FLUX: --job-name=selectLonLat
#FLUX: --queue=regular
#FLUX: -t=21600
#FLUX: --urgency=16

!/bin/bash
echo "### Starting at: $(date) ###"
module spider cray-netcdf
module load e4s
spack env activate gcc
spack load cdo
startYear=1979
endYear=2021
startMonth=01
endMonth=12
for years in $(seq -w ${startYear} ${endYear}); do
        for months in $(seq -w ${startMonth} ${endMonth}); do
                directory="/global/cfs/projectdirs/m3522/cmip6/ERA5/e5.mx2t_daily/e5.mx2t_daily.${years}${months}.nc"
                directoryNew="/pscratch/sd/j/jsnorth/ERA5MonthlyMax/Data/mx2t_daily_${years}${months}.nc"
                # cdo sellonlatbox,-128,-116,44,53 directory directoryNew # only subsets data
                cdo sellonlatbox,-128,-116,44,53 -monmax $directory $directoryNew # subsets and computes monthly max
                echo "cdo sellonlatbox,-128,-116,44,53 -monmax $directory $directoryNew # subsets and computes monthly max"
        done
done
echo "### Ending at: $(date) ###"
