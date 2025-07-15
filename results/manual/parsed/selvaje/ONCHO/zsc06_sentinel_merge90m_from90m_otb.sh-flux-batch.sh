#!/bin/bash
#FLUX: --job-name=zsc06_sentinel_merge90m_from90m_otb.sh
#FLUX: --urgency=16

export file='$(ls $IN/??.vrt   | head -$SLURM_ARRAY_TASK_ID | tail -1 )'
export filename='$(basename $file .vrt  )'
export GDAL_CACHEMAX='99999'
export OTB_MAX_RAM_HINT='10000'

source ~/bin/gdal3
ONCHO=/gpfs/gibbs/project/sbsc/ga254/dataproces/ONCHO
SENT=/gpfs/gibbs/project/sbsc/ga254/dataproces/ONCHO/input_orig/sentinel
IN=/gpfs/gibbs/project/sbsc/ga254/dataproces/ONCHO/input_orig/sentinel/tif_wgs84_90m_tile
OUT=/gpfs/gibbs/project/sbsc/ga254/dataproces/ONCHO/input_orig/sentinel/tif_wgs84_90m_from90m_otb
RAM=/dev/shm
                                                   # xmin ymin xmax ymax
                                               #       2   4    15    15 
export file=$(ls $IN/??.vrt   | head -$SLURM_ARRAY_TASK_ID | tail -1 )
export filename=$(basename $file .vrt  )
apptainer exec  ~/bin/orfeotoolbox.sif bash <<EOF
export GDAL_CACHEMAX=99999
export OTB_MAX_RAM_HINT=10000
otbcli_Mosaic -interpolator linear  -output.spacingx 0.0008333333333333  -output.spacingy 0.0008333333333333 -nodata 0 -harmo.method band -comp.feather slim -comp.feather.slim.length  0.008333333333333 -il $(gdalinfo $file | grep "\.tif" | awk '{ printf ("%s " , $1 ) }' )  -out $OUT/tile_all_90m_otb_${filename}4.tif  -ram 10000
gdal_translate -ot  UInt16 -projwin $(getCorners4Gtranslate $file)  -a_ullr $(getCorners4Gtranslate $file)  -co COMPRESS=DEFLATE -co ZLEVEL=9 $OUT/tile_all_90m_otb_${filename}4.tif $OUT/tile_all_90m_otb_slim_harm_${filename}.tif
rm $OUT/tile_all_90m_otb_${filename}4.tif
otbcli_Mosaic -interpolator linear  -output.spacingx 0.0008333333333333  -output.spacingy 0.0008333333333333 -nodata 0  -comp.feather large -il $(gdalinfo $file | grep "\.tif" | awk '{ printf ("%s " , $1 ) }' )  -out $OUT/tile_all_90m_otb_${filename}1.tif  -ram 10000
gdal_translate -ot  UInt16 -projwin $(getCorners4Gtranslate $file)  -a_ullr $(getCorners4Gtranslate $file)  -co COMPRESS=DEFLATE -co ZLEVEL=9 $OUT/tile_all_90m_otb_${filename}1.tif $OUT/tile_all_90m_otb_large_${filename}.tif
rm $OUT/tile_all_90m_otb_${filename}1.tif
otbcli_Mosaic -interpolator linear  -output.spacingx 0.0008333333333333  -output.spacingy 0.0008333333333333 -nodata 0  -comp.feather large -harmo.method band   -il $(gdalinfo $file | grep "\.tif" | awk '{ printf ("%s " , $1 ) }'  )  -out $OUT/tile_all_90m_otb_${filename}2.tif  -ram 10000
gdal_translate -ot  UInt16 -projwin $(getCorners4Gtranslate $file)  -a_ullr $(getCorners4Gtranslate $file)  -co COMPRESS=DEFLATE -co ZLEVEL=9 $OUT/tile_all_90m_otb_${filename}2.tif $OUT/tile_all_90m_otb_large_harm_${filename}.tif
rm $OUT/tile_all_90m_otb_${filename}2.tif
otbcli_Mosaic -interpolator linear  -output.spacingx 0.0008333333333333  -output.spacingy 0.0008333333333333 -nodata 0  -comp.feather slim -comp.feather.slim.length 0.008333333333333 -il $(gdalinfo $file | grep "\.tif" | awk '{ printf ("%s " , $1 ) }' )  -out $OUT/tile_all_90m_otb_${filename}3.tif  -ram 10000
gdal_translate -ot  UInt16 -projwin $(getCorners4Gtranslate $file)  -a_ullr $(getCorners4Gtranslate $file)  -co COMPRESS=DEFLATE -co ZLEVEL=9 $OUT/tile_all_90m_otb_${filename}3.tif $OUT/tile_all_90m_otb_slim_${filename}.tif
rm $OUT/tile_all_90m_otb_${filename}3.tif
EOF
