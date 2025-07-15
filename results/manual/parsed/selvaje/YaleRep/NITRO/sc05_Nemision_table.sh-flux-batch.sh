#!/bin/bash
#FLUX: --job-name=milky-itch-8232
#FLUX: --urgency=16

export DIR='/gpfs/loomis/project/fas/sbsc/ga254/dataproces/NITRO'
export RAM='/dev/shm'

export DIR=/gpfs/loomis/project/fas/sbsc/ga254/dataproces/NITRO
export RAM=/dev/shm
pksetmask -co COMPRESS=DEFLATE -co ZLEVEL=9 -m $DIR/global_prediction/map_pred_NO3_mask.tif -msknodata -1 -nodata -9999  -i /gpfs/loomis/project/fas/sbsc/ga254/dataproces/COSCAT/tif/COSCAT_1km.tif  -o  $DIR/COSCAT/COSCAT_1km_msk.tif 
gdal_translate -projwin $( getCorners4Gtranslate $DIR/global_prediction/map_pred_NO3_mask.tif )  --config GDAL_NUM_THREADS 2 --config GDAL_CACHEMAX 10000 -of XYZ $DIR/COSCAT/COSCAT_1km_msk.tif $DIR/COSCAT/COSCAT_1km_msk.txt
awk ' { if($3 != -9999  ) print $3  }'   $DIR/COSCAT/COSCAT_1km_msk.txt  >  $DIR/COSCAT/COSCAT_1km_msk_clean.txt
rm -f $DIR/COSCAT/COSCAT_1km_msk.txt
echo "FID,Cell_ID,Qmax,Qmean,Qmin,S,NH4,NO3,TN,Tp,WQmean,Length,AreaP,Prec,Coscat" > $DIR/emision_table.txt
paste <( seq 1 19892976) $DIR/global_wsheds/global_grid_ID_mskNO3_clean.txt  \
$DIR/FLO1K/FLO1K.ts.1960.2015.qma_max_clean.txt $DIR/FLO1K/FLO1K.ts.1960.2015.qav_mean_clean.txt $DIR/FLO1K/FLO1K.ts.1960.2015.qmi_min_clean.txt \
$DIR/global_wsheds/slope_1KMmean_MERIT_stream_clean.txt  \
$DIR/global_prediction/map_pred_DNH4_mask_clean.txt $DIR/global_prediction/map_pred_NO3_mask_clean.txt $DIR/global_prediction/map_pred_TN_mask_clean.txt \
 <(awk ' {print $1/10 }'  $DIR/global_wsheds/tmean_wavg_stream_clean.txt)  \
 <(awk ' {print   exp ((0.571 * log ( $1 )) + 1.771 ) }'  $DIR/FLO1K/FLO1K.ts.1960.2015.qav_mean_clean.txt  )  \
 <(awk ' {print  sqrt ( $1 ) *  1.285892198   }' $DIR/global_wsheds/30arc-sec-Area_prj6842_mskNO3_clean.txt )   \
 $DIR/global_wsheds/30arc-sec-Area_prj6842_mskNO3_clean.txt   \
 $DIR/global_wsheds/monthly_prec_mean_mskNO3_clean.txt  \
 $DIR/COSCAT/COSCAT_1km_msk_clean.txt                >> $DIR/emision_table.txt
awk '{ if ($3 != -1 && $4 != -1 && $3 != 0 && $4 != 0 ) print  }' $DIR/emision_table.txt >  $DIR/emision_table_valid.txt
awk '{ if ($3 == -1 || $4 == -1 || $3 == 0 || $4 == 0 ) print  }' $DIR/emision_table.txt >  $DIR/emision_table_notvalid.txt
awk '{ if ($4 > $3 ) { print $1,$2,$3,$3/8.72292,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14} else {print $0} }'  $DIR/emision_table_valid.txt  >  $DIR/emision_table_valid_cor_area_width_prec.txt
cd $DIR 
GZIP=-9 
tar -czvf    $DIR/emision_table_valid_cor_area_width_prec.tar.gz   $DIR/emision_table_valid_cor_area_width_prec.txt
exit 
rm -f $DIR/global_wsheds/slope_1KMmean_MERIT_stream.txt  $DIR/global_wsheds/tmean_wavg_stream.txt   
exit 
