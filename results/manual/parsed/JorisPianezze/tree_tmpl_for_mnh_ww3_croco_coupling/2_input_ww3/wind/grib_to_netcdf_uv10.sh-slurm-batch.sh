#!/bin/bash
#FLUX: --job-name=prep_wind_for_ww3
#FLUX: -t=3600
#FLUX: --urgency=16

dirin=../era5/
file=era5
dates='20210914 20210915'
hours='00 06 12 18'
forecast='00'
fileout='wind.nc'
for day in $dates
do
  for hour in $hours
  do
    for fc in $forecast
    do
      # extract the hs variable from the ecmwf file
      #grib_filter filter_wind ${dirin}/${file}.${day}.${hour}.${fc}
      grib_filter filter_wind ${dirin}/${file}.${day}.${hour}
      # convert to netcdf in float
      grib_to_netcdf -D NC_FLOAT ${day}_u10.grib1 -o u10_$day.${hour}.${fc}.nc
      grib_to_netcdf -D NC_FLOAT ${day}_v10.grib1 -o v10_$day.${hour}.${fc}.nc
 # menage
   rm ${day}_*.grib1
   # make record variable (time) unlimited
    ncks -O --mk_rec_dmn time u10_$day.${hour}.${fc}.nc u10_$day.${hour}.${fc}.nc
    ncks -O --mk_rec_dmn time v10_$day.${hour}.${fc}.nc v10_$day.${hour}.${fc}.nc
    done  # end of the forecast hours
  done # end of the "reseaux"
done # end of the days
ncrcat u10_????????.??.??.nc u10_cat.nc
ncrcat v10_????????.??.??.nc v10_cat.nc
rm u10_????????.??.??.nc
rm v10_????????.??.??.nc
cp u10_cat.nc ${fileout}
ncks -A -v v10 v10_cat.nc ${fileout}
ncap2 -s 'time2=double(time)/24' ${fileout} uv10_cat_time.nc
ncap2 -O -s 'latitude2=double(latitude)' uv10_cat_time.nc uv10_cat_time.nc
ncap2 -O -s 'longitude2=double(longitude)' uv10_cat_time.nc uv10_cat_time.nc
ncatted -O -a units,time2,d,s,"hours since 1900-01-01 00:00:0.0" uv10_cat_time.nc uv10_cat_time2.nc
ncatted -O -a calendar,time2,m,c,"standard" uv10_cat_time2.nc 
ncatted -O -a units,time2,c,c,"days since 1900-01-01T00:00:00Z" uv10_cat_time2.nc
ncks -C -x -v time,latitude,longitude uv10_cat_time2.nc uv10_cat_time3.nc
ncrename -O -v time2,time uv10_cat_time3.nc uv10_cat_time3.nc
ncatted -O -a long_name,u10,m,c,"u10m" uv10_cat_time3.nc uv10_cat_time3.nc
ncatted -O -a long_name,v10,m,c,"v10m" uv10_cat_time3.nc uv10_cat_time3.nc
ncrename -O -v u10,u10m uv10_cat_time3.nc uv10_cat_time3.nc
ncrename -O -v v10,v10m uv10_cat_time3.nc uv10_cat_time3.nc
ncatted -O -a standard_name,latitude2,c,c,"latitude" uv10_cat_time3.nc uv10_cat_time3.nc
ncatted -O -a axis,latitude2,c,c,"Y" uv10_cat_time3.nc uv10_cat_time3.nc
ncatted -O -a standard_name,longitude2,c,c,"longitude" uv10_cat_time3.nc uv10_cat_time3.nc
ncatted -O -a axis,longitude2,c,c,"X" uv10_cat_time3.nc uv10_cat_time3.nc
ncrename -O -v latitude2,latitude uv10_cat_time3.nc uv10_cat_time3.nc
ncrename -O -v longitude2,longitude uv10_cat_time3.nc uv10_cat_time3.nc
ncpdq -O -a -latitude uv10_cat_time3.nc uv10_cat_time3.nc
mv uv10_cat_time3.nc ${fileout}
rm uv10_cat_time.nc
rm uv10_cat_time2.nc
rm u10_cat.nc
rm v10_cat.nc
