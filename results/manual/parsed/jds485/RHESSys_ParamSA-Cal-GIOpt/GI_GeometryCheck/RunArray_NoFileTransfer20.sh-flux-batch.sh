#!/bin/bash
#FLUX: --job-name=eccentric-signal-0425
#FLUX: --queue=standard
#FLUX: -t=1200
#FLUX: --urgency=16

module purge
module load singularity
SINGIMAGE='/share/resources/containers/singularity/rhessys'
BASEDIR='/scratch/js4yd/GI_RandomSeedEval910'
RLIBPATH='/home/js4yd/R/x86_64-pc-linux-gnu-library/3.5'
EPSGCODE='EPSG:26918'
RESOLUTION=30 #spatial resolution (meters) of the grids
RHESSysNAME='RHESSys_Baisman30m_g74' # e.g., rhessys_baisman10m
LOCATION_NAME="g74_$RHESSysNAME"
MAPSET=PERMANENT
RHESSysModelLoc="/scratch/js4yd/RHESSysEastCoast_Optimized"
i=${SLURM_ARRAY_TASK_ID}
cd "$BASEDIR"/RHESSysRuns
mkdir ./Run"$i"
mkdir ./Run"$i"/"$RHESSysNAME"
PROJDIR="$BASEDIR"/RHESSysRuns/Run"$i" 
cd "$PROJDIR"
cp -r "$BASEDIR"/"$RHESSysNAME"/worldfiles ./"$RHESSysNAME"
cp -r "$BASEDIR"/"$RHESSysNAME"/tecfiles ./"$RHESSysNAME"
cp -r "$BASEDIR"/"$RHESSysNAME"/output ./"$RHESSysNAME"
cp -r "$BASEDIR"/"$RHESSysNAME"/flows ./"$RHESSysNAME"
mkdir "$PROJDIR"/"$RHESSysNAME"/defs
cp "$BASEDIR"/"$RHESSysNAME"/defs0/* "$PROJDIR"/"$RHESSysNAME"/defs/
cp -r "$BASEDIR"/"$RHESSysNAME"/clim ./"$RHESSysNAME"
cp "$BASEDIR"/"$RHESSysNAME"/lulcFrac30m.csv ./"$RHESSysNAME"
cp "$BASEDIR"/"$RHESSysNAME"/MaxGI30m910.csv ./"$RHESSysNAME"
mkdir ./grass_dataset
cp -r "$BASEDIR"/grass_dataset/"$LOCATION_NAME" ./grass_dataset
mkdir ./GIS2RHESSys
cp "$BASEDIR"/GIS2RHESSys/lulcCollectionEC_Cal.csv ./GIS2RHESSys
cp "$BASEDIR"/GIS2RHESSys/soilCollection_Cal910.csv ./GIS2RHESSys
cp "$BASEDIR"/GIS2RHESSys/vegCollection_modified_Opt910.csv ./GIS2RHESSys
cp "$BASEDIR"/GIS2RHESSys/lulc_1m_Chesapeake_Conservancy.csv ./GIS2RHESSys
singularity exec "$SINGIMAGE"/rhessys_v3.img python "$BASEDIR"/RHESSysRuns/ModifyVeg.py "$BASEDIR"/RHESSysRuns/Run"$i"/GIS2RHESSys "$PROJDIR"/"$RHESSysNAME" "$PROJDIR"/"$RHESSysNAME"/defs 'vegCollection_modified_Opt910.csv'
cd "$PROJDIR"
mkdir ./GIS2RHESSys/libraries
cp "$BASEDIR"/GIS2RHESSys/libraries/g2w_cf_RHESSysEC.R ./GIS2RHESSys/libraries
cp "$BASEDIR"/GIS2RHESSys/libraries/LIB_RHESSys_writeTable2World.R ./GIS2RHESSys/libraries
cp "$BASEDIR"/GIS2RHESSys/libraries/aggregate_lulcFrac_write2GIS.R ./GIS2RHESSys/libraries
mkdir ./Date_analysis
cp "$BASEDIR"/Date_analysis/climate_extension.R ./Date_analysis
cp "$BASEDIR"/Date_analysis/LIB_dailytimeseries3.R ./Date_analysis
cp "$BASEDIR"/Date_analysis/LIB_misc.r ./Date_analysis
mkdir ./raw_data
cp "$BASEDIR"/raw_data/BARN_1mLC_UTM.tif ./raw_data
mkdir ./GIAllocation
cp "$BASEDIR"/GIAllocation/AllocateGI_910_Rivanna.R "$PROJDIR"/GIAllocation
GITHUBLIBRARIES="$PROJDIR"/GIS2RHESSys/libraries
GISDBASE="$PROJDIR"/grass_dataset
LOCATION="$GISDBASE"/$LOCATION_NAME
downloadedLULCfile="$PROJDIR"/'raw_data'/'BARN_1mLC_UTM.tif'
singularity exec "$SINGIMAGE"/rhessys_v3.img grass74 "$LOCATION"/$MAPSET --exec r.in.gdal -e --overwrite input="$downloadedLULCfile" output=lulcRAW location=lulcRAW
LOCATIONLULC="$GISDBASE"/lulcRAW
singularity exec "$SINGIMAGE"/rhessys_v3.img grass74 "$LOCATIONLULC"/$MAPSET --exec v.proj location=$LOCATION_NAME mapset=$MAPSET input=patch output=patch$RESOLUTION'm'
singularity exec "$SINGIMAGE"/rhessys_v3.img grass74 "$LOCATIONLULC"/$MAPSET --exec v.to.rast input=patch$RESOLUTION'm' output=patch$RESOLUTION'm' use=attr attribute_column=value
cp "$BASEDIR"/'Test20.txt' "$PROJDIR"/"$RHESSysNAME"/
singularity exec "$SINGIMAGE"/rhessys_v3.img Rscript "$PROJDIR"/GIAllocation/AllocateGI_910_Rivanna.R "$i" 'MaxGI30m910.csv' 'lulcFrac30m.csv' "$PROJDIR"/"$RHESSysNAME" '2' '3' 'lulcFrac30m_GI.csv' '9' '900' 'Test20.txt'
rm "$PROJDIR"/"$RHESSysNAME"/'Test20.txt'
rm "$PROJDIR"/"$RHESSysNAME"/lulcFrac30m.csv
singularity exec "$SINGIMAGE"/rhessys_v3.img grass74 "$LOCATION"/$MAPSET --exec Rscript "$GITHUBLIBRARIES"/aggregate_lulcFrac_write2GIS.R patch "$PROJDIR"/"$RHESSysNAME"/lulcFrac$RESOLUTION'm_GI.csv' "$PROJDIR"/GIS2RHESSys/lulc_1m_Chesapeake_Conservancy.csv "$RLIBPATH"
singularity exec "$SINGIMAGE"/rhessys_v3.img grass74 "$LOCATION"/$MAPSET --exec r.mapcalc --overwrite expression="grass1StratumID = if(lawnFrac>0,3,null())"
singularity exec "$SINGIMAGE"/rhessys_v3.img grass74 "$LOCATION"/$MAPSET --exec r.mapcalc --overwrite expression="grass1FFrac = if(lawnFrac>0,1.0,null())"
singularity exec "$SINGIMAGE"/rhessys_v3.img grass74 "$LOCATION"/$MAPSET --exec r.mapcalc --overwrite expression="grass1LAI = if(lawnFrac>0,1.5,null())"
singularity exec "$SINGIMAGE"/rhessys_v3.img grass74 "$LOCATION"/$MAPSET --exec r.mapcalc --overwrite expression="tree1StratumID = if(forestBaseFrac>0,102,null())"
singularity exec "$SINGIMAGE"/rhessys_v3.img grass74 "$LOCATION"/$MAPSET --exec r.mapcalc --overwrite expression="tree1FFrac = if(forestBaseFrac>0,1.0,null())"
singularity exec "$SINGIMAGE"/rhessys_v3.img grass74 "$LOCATION"/$MAPSET --exec r.mapcalc --overwrite expression="tree1LAI = if(forestBaseFrac>0,5.5,null())"
singularity exec "$SINGIMAGE"/rhessys_v3.img grass74 "$LOCATION"/$MAPSET --exec r.mapcalc --overwrite expression="tree2StratumID = if(forestGIEvFrac>0,414,null())"
singularity exec "$SINGIMAGE"/rhessys_v3.img grass74 "$LOCATION"/$MAPSET --exec r.mapcalc --overwrite expression="tree2FFrac = if(forestGIEvFrac>0,1.0,null())"
singularity exec "$SINGIMAGE"/rhessys_v3.img grass74 "$LOCATION"/$MAPSET --exec r.mapcalc --overwrite expression="tree2LAI = if(forestGIEvFrac>0,5.5,null())"
templateFile="$PROJDIR"/"$RHESSysNAME"/g2w_template.txt
echo outputWorldfile \""$PROJDIR"/"$RHESSysNAME"/worldfiles/worldfile.csv\" 1 > "$templateFile"
echo outputWorldfileHDR \""$PROJDIR"/"$RHESSysNAME"/worldfiles/worldfile.hdr\" 1 >> "$templateFile"
echo outputDefs \""$PROJDIR"/"$RHESSysNAME"/defs\" 0 >> "$templateFile"
echo outputSurfFlow \""$PROJDIR"/"$RHESSysNAME"/flows/surfflow.txt\" 0 >> "$templateFile"
echo outputSubFlow \""$PROJDIR"/"$RHESSysNAME"/flows/subflow.txt\" 0 >> "$templateFile"
echo stationID 101 >> "$templateFile"
echo stationFile \""clim/Cal_Feb2020Revised.base"\" >> "$templateFile"
echo basinMap basin >> "$templateFile"
echo hillslopeMap hill >> "$templateFile"
echo zoneMAP zone_cluster >> "$templateFile"
echo patchMAP patch >> "$templateFile"
echo soilidMAP soil_texture >> "$templateFile"
echo xMAP xmap >> "$templateFile"
echo yMAP ymap >> "$templateFile"
echo demMAP dem >> "$templateFile"
echo slopeMap slope >> "$templateFile"
echo aspectMAP aspect >> "$templateFile"
echo twiMAP wetness_index >> "$templateFile"
echo whorizonMAP west_180 >> "$templateFile"
echo ehorizonMAP east_000 >> "$templateFile"
echo isohyetMAP isohyet >> "$templateFile"
echo rowMap rowmap >> "$templateFile"
echo colMap colmap >> "$templateFile"
echo drainMap drain >> "$templateFile"
echo impFracMAP impFrac >> "$templateFile"
echo roofMAP roofFrac >> "$templateFile"
echo drivewayMAP drivewayFrac >> "$templateFile"
echo pavedRoadFracMAP pavedroadFrac >> "$templateFile"
echo forestFracMAP forestFrac >> "$templateFile"
echo forestBaseFracMAP forestBaseFrac >> "$templateFile"
echo forestGIEvFracMAP forestGIEvFrac >> "$templateFile"
echo tree1StratumID tree1StratumID >> "$templateFile"
echo tree1FFrac tree1FFrac >> "$templateFile"
echo tree1LAI tree1LAI >> "$templateFile"
echo tree2StratumID tree2StratumID >> "$templateFile"
echo tree2FFrac tree2FFrac >> "$templateFile"
echo tree2LAI tree2LAI >> "$templateFile"
echo shrubFracMAP shrubFrac >> "$templateFile"
echo cropFracMAP cropFrac >> "$templateFile"
echo grassFracMAP lawnFrac >> "$templateFile"
echo grass1StratumID grass1StratumID >> "$templateFile"
echo grass1FFrac grass1FFrac >> "$templateFile"
echo grass1LAI grass1LAI >> "$templateFile"
echo streamMap str >> "$templateFile"
echo streamFullExtension strExt >> "$templateFile"
echo riparianMAP riparian_hands >> "$templateFile"
echo septicMAP septic >> "$templateFile"
echo stormdrainMAP roadExit >> "$templateFile"
echo compactedsoilMAP compactedsoil >> "$templateFile"
echo additionalSurfaceDrainMAP addsurfdrain >> "$templateFile"
cd "$PROJDIR"
singularity exec "$SINGIMAGE"/rhessys_v3.img grass74 "$LOCATION"/$MAPSET --exec Rscript "$GITHUBLIBRARIES"/g2w_cf_RHESSysEC.R "$PROJDIR" "$PROJDIR"/"$RHESSysNAME"/vegCollection_modified_Opt910.csv "$PROJDIR"/GIS2RHESSys/soilCollection_Cal910.csv "$PROJDIR"/GIS2RHESSys/lulcCollectionEC_Cal.csv "$templateFile" "$RLIBPATH"
singularity exec "$SINGIMAGE"/rhessys_v3.img Rscript "$GITHUBLIBRARIES"/LIB_RHESSys_writeTable2World.R NA "$PROJDIR"/"$RHESSysNAME"/worldfiles/worldfile.csv "$PROJDIR"/"$RHESSysNAME"/worldfiles/worldfile "$RLIBPATH"
rm -r "$PROJDIR"/grass_dataset
rm -r "$PROJDIR"/Date_analysis
rm -r "$PROJDIR"/GIS2RHESSys
rm -r "$PROJDIR"/raw_data
rm -r "$PROJDIR"/GIAllocation
rm "$PROJDIR"/"$RHESSysNAME"/g2w_template.txt
rm "$PROJDIR"/"$RHESSysNAME"/MaxGI30m910.csv
rm "$PROJDIR"/"$RHESSysNAME"/vegCollection_modified_Opt910.csv
cd "$PROJDIR"/"$RHESSysNAME"
$RHESSysModelLoc/rhessys5.20.0.develop_optimsize -st 1999 11 15 1 -ed 2013 10 1 1 -b -h -newcaprise -gwtoriparian -capMax 0.01 -slowDrain -t tecfiles/tec_daily_cal.txt -w worldfiles/worldfile -whdr worldfiles/worldfile.hdr -r flows/subflow.txt flows/surfflow.txt -pre output/Run"$i" -s 1 1 1 -sv 1 1 -gw 1 1 -svalt 1 1 -vgsen 1 1 1 -snowTs 1 -snowEs 1 -capr 0.001
rm -r ./flows
rm -r ./clim
rm -r ./tecfiles
rm -r ./worldfiles
rm -r ./defs
rm ./output/Run"$i"_basin.hourly
rm ./output/Run"$i"_basin.monthly
rm ./output/Run"$i"_basin.yearly
rm ./output/Run"$i"_hillslope.hourly
rm ./output/Run"$i"_hillslope.monthly
rm ./output/Run"$i"_hillslope.yearly
rm ./output/*.params
