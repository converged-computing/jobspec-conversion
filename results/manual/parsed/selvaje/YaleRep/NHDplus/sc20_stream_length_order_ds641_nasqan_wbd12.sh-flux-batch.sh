#!/bin/bash
#FLUX: --job-name=sc20_stream_length_order_ds641_nasqan_wbd12.sh
#FLUX: --priority=16

NHD=/project/fas/sbsc/ga254/dataproces/NHDplus
file=$(ls $NHD/ds641_nasqan_wbd12_wgs84/*.shp  | head  -n  $SLURM_ARRAY_TASK_ID | tail  -1 )
echo start the loop  $file 
filename=$( basename  $file  .shp )
ogr2ogr -overwrite -spat $(ogrinfo -al -so $file | grep Extent | awk '{ gsub ("[(),]",""); print $2,$3,$5,$6 }')  -sql "SELECT  LENGTHKM, StreamOrde  FROM 'unionLayer' WHERE ( FTYPE = 'StreamRiver')  OR ( FTYPE = 'Connector')  OR ( FTYPE = 'ArtificialPath')  "   $NHD/ds641_nasqan_wbd12_wgs84_crop/${filename}_streams.shp $NHD/shp/NHDFlowline.vrt
ogr2ogr -overwrite -clipdst $file $NHD/ds641_nasqan_wbd12_wgs84_clip_streams/$filename.shp $NHD/ds641_nasqan_wbd12_wgs84_crop/${filename}_streams.shp 
ogrinfo -al -geom=NO   -where  " FTYPE='StreamRiver' OR  FTYPE='Connector' OR  FTYPE='ArtificialPath' "  $NHD/ds641_nasqan_wbd12_wgs84_clip_streams/$filename.shp  |  grep -e StreamOrde  -e  LENGTHKM -e FTYPE   | awk '{  if($1=="StreamOrde") { printf("%s\n", $4) }  else {  printf("%s ", $4) }}' | awk '{ print $2"_"$3, $1  , 1 }' | sort -k 1,1  >  $NHD/ds641_nasqan_wbd12_wgs84_clip_streams_txt/${filename}_streams_oder.txt 
/gpfs/home/fas/sbsc/ga254/scripts/WWF_ECO/sum.sh  $NHD/ds641_nasqan_wbd12_wgs84_clip_streams_txt/${filename}_streams_oder.txt  $NHD/ds641_nasqan_wbd12_wgs84_clip_streams_txt/${filename}_streams_oder_sum.txt  <<EOF
n
1
3
EOF
awk '{ gsub("_"," " ) ; print $1 ","  $2  "," $3 "," int($4) }'  $NHD/ds641_nasqan_wbd12_wgs84_clip_streams_txt/${filename}_streams_oder_sum.txt >  $NHD/ds641_nasqan_wbd12_wgs84_clip_streams_txt/${filename}_streams_oder_sum.csv
