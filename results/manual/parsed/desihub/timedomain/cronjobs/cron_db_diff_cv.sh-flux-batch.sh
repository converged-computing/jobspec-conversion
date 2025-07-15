#!/bin/bash
#FLUX: --job-name=gassy-platanos-3239
#FLUX: -t=7200
#FLUX: --priority=16

echo `date` Running daily time domain pipeline on `hostname`
if [ -z "$DESI_ROOT" ]; then
    echo "Loading DESI modules"
    module use /global/common/software/desi/$NERSC_HOST/desiconda/startup/modulefiles
    echo "module load"
    module load desimodules/master
fi
tiles_path="/global/project/projectdirs/desi/spectro/redux/daily/tiles"
run_path="/global/cscratch1/sd/akim/project/timedomain/cronjobs/"
td_path="/global/cfs/cdirs/desi/science/td/daily-search/"
echo "Looking for new exposures"
python ${run_path}exposure_db.py daily
query="select distinct obsdate,tileid from exposures
where (tileid,obsdate) not in (select tileid,obsdate from desidiff_cv_coadd_exposures);"
mapfile -t -d $'\n' obsdates_tileids < <( sqlite3 ${td_path}transients_search.db "$query" )
now=$( date -d "today" '+%Y%m%d_%T' )
logfile="${td_path}desitrip/log/${now}.log"
echo "Putting log into "$logfile
echo "#!/bin/bash
">${run_path}sbatch_file.sh
Nobsdates_tileids=${#obsdates_tileids[@]}
if [ $Nobsdates_tileids -eq 0 ]; then
    echo "No new observations found today"
else
    echo "$Nobsdates_tileids new observations found"
    echo "---------- Starting coadd differencing ----------"
    run_path_diff="/global/cscratch1/sd/akim/project/timedomain/timedomain/bin/"
    logfile="${td_path}/desitrip/log/${now}.log"
    # instead of doing all the date/tile pairs at once, split into pieces
    # the purpose is to have more things get processed/saved in case of
    # any kind of error
    nper=1
    nloop=$(((Nobsdates_tileids+nper-1)/nper))
    for ((i=0;i<$nloop;i++)); 
        do 
            subarr=("${obsdates_tileids[@]:$(($i*$nper)):$nper}")
            echo "${subarr[@]}"
    #     echo "${run_path_diff}/diff-db.py $lastnite CVLogic Date_SpectraPairs_Iterator daily
    #     coadd"
    #     srun -o ${logfile} ${run_path_diff}/diff.py $lastnite CVLogic
    #     Date_SpectraPairs_Iterator daily coadd
            python ${run_path_diff}diff-db.py TileDate_SpectraPairs_Iterator CVLogic daily coadd --obsdates_tilenumbers ${subarr[@]}
            if [ $? -eq 0 ]
            then
                echo "Successfully executed script"
                #Now add this tile info to the sqlite db
                for t in ${subarr[@]}; do
                    arrt=(${t//|/ })
                    query="INSERT OR IGNORE INTO desidiff_cv_coadd_exposures(obsdate, tileid) VALUES(${arrt[0]},${arrt[1]});"
                    echo $query
                    sqlite3 ${td_path}transients_search.db "$query"
                done
            else
              # Redirect stdout from echo command to stderr.
                echo "Script encountered error." >&2
                exit 1
            fi
        done
fi
