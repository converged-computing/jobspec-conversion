#!/bin/bash
#FLUX: --job-name=expensive-puppy-5672
#FLUX: --urgency=16

module load singularity
SINGIMAGE='/share/resources/containers/singularity/rhessys'
BASEDIR='/scratch/js4yd/MorrisSA'
RLIBPATH='/home/js4yd/R/x86_64-pc-linux-gnu-library/3.5'
EPSGCODE='EPSG:26918'
RESOLUTION=30 #spatial resolution (meters) of the grids
RHESSysNAME='RHESSys_Baisman30m_g74' # e.g., rhessys_baisman10m
LOCATION_NAME="g74_$RHESSysNAME"
MAPSET=PERMANENT
RHESSysModelLoc="/scratch/js4yd/RHESSysEastCoast"
OUTDIR="/nv/vol288/quinnlab-value/js4yd/Baisman30m_MorrisSA"
SUBONE=1
i=$(expr ${SLURM_ARRAY_TASK_ID} - $SUBONE) 
cd "$BASEDIR"/RHESSysRuns
singularity exec "$SINGIMAGE"/rhessys_v3.img python "$BASEDIR"/RHESSysRuns/MakeDefs_fn.py "$i" "$BASEDIR"/RHESSysRuns "$BASEDIR"/"$RHESSysNAME"/defs "$RHESSysNAME" 'BaismanMorrisSamplingProblemFile_Full.csv' '10'
PROJDIR="$BASEDIR"/RHESSysRuns/Run"$i" 
cd "$PROJDIR"
mkdir ./grass_dataset
cp -r "$BASEDIR"/grass_dataset/"$LOCATION_NAME" ./grass_dataset
mkdir ./GIS2RHESSys
cp "$BASEDIR"/GIS2RHESSys/lulcCollectionEC_SA.csv ./GIS2RHESSys
cp "$BASEDIR"/GIS2RHESSys/soilCollection_SA.csv ./GIS2RHESSys
cp "$BASEDIR"/GIS2RHESSys/vegCollection_modified_SA.csv ./GIS2RHESSys
singularity exec "$SINGIMAGE"/rhessys_v3.img python "$BASEDIR"/RHESSysRuns/ModifyVeg.py "$BASEDIR"/RHESSysRuns/Run"$i"/GIS2RHESSys "$PROJDIR"/"$RHESSysNAME" "$PROJDIR"/"$RHESSysNAME"/defs 'vegCollection_modified_SA.csv'
cd "$PROJDIR"
mkdir ./GIS2RHESSys/libraries
cp "$BASEDIR"/GIS2RHESSys/libraries/g2w_cf_RHESSysEC.R ./GIS2RHESSys/libraries
cp "$BASEDIR"/GIS2RHESSys/libraries/LIB_RHESSys_writeTable2World.R ./GIS2RHESSys/libraries
mkdir ./Date_analysis
cp "$BASEDIR"/Date_analysis/climate_extension.R ./Date_analysis
cp "$BASEDIR"/Date_analysis/LIB_dailytimeseries3.R ./Date_analysis
cp "$BASEDIR"/Date_analysis/LIB_misc.r ./Date_analysis
cp -r "$BASEDIR"/"$RHESSysNAME"/worldfiles ./"$RHESSysNAME"
cp -r "$BASEDIR"/"$RHESSysNAME"/tecfiles ./"$RHESSysNAME"
cp -r "$BASEDIR"/"$RHESSysNAME"/output ./"$RHESSysNAME"
cp -r "$BASEDIR"/"$RHESSysNAME"/flows ./"$RHESSysNAME"
cp -r "$BASEDIR"/"$RHESSysNAME"/clim ./"$RHESSysNAME"
cp "$BASEDIR"/"$RHESSysNAME"/soil_cat_mukey.csv ./"$RHESSysNAME"
cp "$BASEDIR"/"$RHESSysNAME"/lulcFrac30m.csv ./"$RHESSysNAME"
GITHUBLIBRARIES="$BASEDIR"/RHESSysRuns/Run"$i"/GIS2RHESSys/libraries
GISDBASE="$PROJDIR"/grass_dataset
LOCATION="$GISDBASE"/$LOCATION_NAME
templateFile="$PROJDIR"/"$RHESSysNAME"/g2w_template.txt
echo outputWorldfile \""$PROJDIR"/"$RHESSysNAME"/worldfiles/worldfile.csv\" 1 > "$templateFile"
echo outputWorldfileHDR \""$PROJDIR"/"$RHESSysNAME"/worldfiles/worldfile.hdr\" 0 >> "$templateFile"
echo outputDefs \""$PROJDIR"/"$RHESSysNAME"/defs\" 0 >> "$templateFile"
echo outputSurfFlow \""$PROJDIR"/"$RHESSysNAME"/flows/surfflow.txt\" 0 >> "$templateFile"
echo outputSubFlow \""$PROJDIR"/"$RHESSysNAME"/flows/subflow.txt\" 0 >> "$templateFile"
echo stationID 101 >> "$templateFile"
echo stationFile \""clim/Oregon.base"\" >> "$templateFile"
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
singularity exec "$SINGIMAGE"/rhessys_v3.img grass74 "$LOCATION"/$MAPSET --exec Rscript "$GITHUBLIBRARIES"/g2w_cf_RHESSysEC.R "$PROJDIR" "$PROJDIR"/"$RHESSysNAME"/vegCollection_modified_SA.csv "$PROJDIR"/GIS2RHESSys/soilCollection_SA.csv "$PROJDIR"/GIS2RHESSys/lulcCollectionEC_SA.csv "$templateFile" "$RLIBPATH"
singularity exec "$SINGIMAGE"/rhessys_v3.img Rscript "$GITHUBLIBRARIES"/LIB_RHESSys_writeTable2World.R NA "$PROJDIR"/"$RHESSysNAME"/worldfiles/worldfile.csv "$PROJDIR"/"$RHESSysNAME"/worldfiles/worldfile "$RLIBPATH"
rm -r "$PROJDIR"/grass_dataset
cd "$PROJDIR"/"$RHESSysNAME"
"$RHESSysModelLoc"/rhessys5.20.0.develop -st 1999 11 15 1 -ed 2010 10 1 1 -b -h -newcaprise -gwtoriparian -capMax 0.01 -slowDrain -t tecfiles/tec_daily_SA.txt -w worldfiles/worldfile -whdr worldfiles/worldfile.hdr -r flows/subflow.txt flows/surfflow.txt -pre output/BaismanRun"$i" -s 1 1 1 -sv 1 1 -gw 1 1 -svalt 1 1 -vgsen 1 1 1 -snowTs 1 -snowEs 1 -capr 0.001
mkdir "$OUTDIR"/Run"$i"
mv "$PROJDIR"/"$RHESSysNAME"/output "$OUTDIR"/Run"$i"/
mv "$PROJDIR"/"$RHESSysNAME"/defs "$OUTDIR"/Run"$i"/
mv "$PROJDIR"/"$RHESSysNAME"/worldfiles "$OUTDIR"/Run"$i"/
rm -r "$PROJDIR"
