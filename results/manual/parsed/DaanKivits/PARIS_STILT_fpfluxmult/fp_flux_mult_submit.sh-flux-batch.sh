#!/bin/bash
#FLUX: --job-name=STILT_fpflux
#FLUX: -t=900
#FLUX: --urgency=16

export OPENBLAS_NUM_TRHEADS='1'
export OMP_NUM_THREADS='1'

export OPENBLAS_NUM_TRHEADS=1
export OMP_NUM_THREADS=1
module load 2023
module load Anaconda3/2023.07-2
source activate cte-hr-env
perturbation=$1
sum=$2
fpdir='/projects/0/ctdas/PARIS/DATA/footprints/wur/PARIS_recompile/'
bgdir='/projects/0/ctdas/PARIS/DATA/background/STILT/'
obspack_path='/projects/0/ctdas/PARIS/DATA/obs/obspack_co2_466_GVeu_20230913.zip'
non_obspack_path='/projects/0/ctdas/PARIS/DATA/obs/non_obspacksites/'
stiltdir='/projects/0/ctdas/PARIS/transport_models/STILT_Model/STILT_Exe/'
stationsfile='/projects/0/ctdas/PARIS/DATA/obs/stations/stationfile_uob_wur_ganesan_manning.csv'
start_date="2021-01-01"
end_date="2022-01-01"
lat_ll=33.0
lat_ur=72.0
lon_ll=-15.0
lon_ur=35.0
lon_step=0.2
lat_step=0.1
sim_len=240
verbose='True'
fluxtype="PARIS"
if [ ${fluxtype} = "PARIS" ]; then
    echo 'Using PARIS fluxes'
    fluxdir='/projects/0/ctdas/PARIS/CTE-HR/PARIS_OUTPUT/'
    # Define output directory based on perturbation experiment
    outdir="/projects/0/ctdas/PARIS/DATA/obspacks/${perturbation}/"
elif [ ${fluxtype} = "CTEHR" ]; then
    echo 'Using CTE-HR fluxes'
    fluxdir='/projects/0/ctdas/awoude/NRT/ICOS_OUTPUT/'
    # Define output directory based on perturbation experiment
    outdir="/projects/0/ctdas/PARIS/DATA/obspacks/CTE-HR/"
else
    echo "Please specify a valid fluxtype. Choose between "CTEHR" or "PARIS"."
fi
if [ ! -d "${outdir}" ]; then
    mkdir -p ${outdir}
fi
LOGDIR="${outdir}logs/"
if [ ! -d "${LOGDIR}" ]; then
    mkdir -p ${LOGDIR}
fi
echo "Starting multiple FP-FLUX multiplication calculations in parallel!"
N_LINES=$(tail -n +1 < $stationsfile | wc -l)        # get number of lines in stationsfile
echo "Number of stations in  station file: $N_LINES"
N_JOBS=2                # get number of jobs
echo 'Start date: ' $start_date
echo 'End date: ' $end_date
for ((i=2;i<=$N_JOBS;i++))
do
    # Extract station name from stationsfile
    # NOTE: It extracts the station_name from the second column of stationsfile. 
    # If the stationcode is in another column, specify that column here.
    station=$(awk -F',' -v row="$i" 'NR==row {print $2}' "$stationsfile")
    stationname=$(awk -F',' -v row="$i" 'NR==row {print $1}' "$stationsfile")
    # Define logfile
    LOGFILE="${LOGDIR}${station}_fp_mult.log"
    # Remove logfile if it already exists
    if [ -f "$LOGFILE" ]; then
        rm $LOGFILE
    fi
    echo "Starting script for station ${stationname} (code: ${station})"
    # Run the STILT model for the current station and with the other user-specified arguments
    if [ $verbose = 'True' ]; then
            if [ $sum = 'True' ]; then
                    python /projects/0/ctdas/PARIS/STILT_CTEHR_scripts/fp_flux_mult/fp_flux_mult_singlerun.py --verbose --sum-variables --fluxtype $fluxtype --station $station --stationsfile $stationsfile --fluxdir $fluxdir --fpdir $fpdir --bgdir $bgdir --outdir $outdir --stiltdir $stiltdir --obspack_path $obspack_path --non_obspack_path $non_obspack_path --start_date $start_date --end_date $end_date --lat_ll $lat_ll --lat_ur $lat_ur --lon_ll $lon_ll --lon_ur $lon_ur --lat_step $lat_step --lon_step $lon_step --sim_len $sim_len --perturbation $perturbation >> ${LOGFILE} 2>&1 & # Run your executable, note the "&"
                    echo "option 1"
            else
                    python /projects/0/ctdas/PARIS/STILT_CTEHR_scripts/fp_flux_mult/fp_flux_mult_singlerun.py --verbose --fluxtype $fluxtype --station $station --stationsfile $stationsfile --fluxdir $fluxdir --fpdir $fpdir --bgdir $bgdir --outdir $outdir --stiltdir $stiltdir --obspack_path $obspack_path --non_obspack_path $non_obspack_path --start_date $start_date --end_date $end_date --lat_ll $lat_ll --lat_ur $lat_ur --lon_ll $lon_ll --lon_ur $lon_ur --lat_step $lat_step --lon_step $lon_step --sim_len $sim_len --perturbation $perturbation >> ${LOGFILE} 2>&1 & # Run your executable, note the "&"
                    echo "option 2"
            fi
    else
            if [ $sum = 'True' ]; then
                    python /projects/0/ctdas/PARIS/STILT_CTEHR_scripts/fp_flux_mult/fp_flux_mult_singlerun.py --sum-variables --fluxtype $fluxtype --station $station --stationsfile $stationsfile --fluxdir $fluxdir --fpdir $fpdir --bgdir $bgdir --outdir $outdir --stiltdir $stiltdir --obspack_path $obspack_path --non_obspack_path $non_obspack_path --start_date $start_date --end_date $end_date --lat_ll $lat_ll --lat_ur $lat_ur --lon_ll $lon_ll --lon_ur $lon_ur --lat_step $lat_step --lon_step $lon_step --sim_len $sim_len --perturbation $perturbation >> ${LOGFILE} 2>&1 & # Run your executable, note the "&"
                    echo "option 3"
            else
                    #python -m cProfile -o profile.out /projects/0/ctdas/PARIS/STILT_CTEHR_scripts/fp_flux_mult/fp_flux_mult_singlerun.py --fluxtype $fluxtype --station $station --stationsfile $stationsfile --fluxdir $fluxdir --fpdir $fpdir --bgdir $bgdir --outdir $outdir --stiltdir $stiltdir --obspack_path $obspack_path --non_obspack_path $non_obspack_path --start_date $start_date --end_date $end_date --lat_ll $lat_ll --lat_ur $lat_ur --lon_ll $lon_ll --lon_ur $lon_ur --lat_step $lat_step --lon_step $lon_step --sim_len $sim_len --perturbation $perturbation >> ${LOGFILE} 2>&1 & # Run your executable, note the "&"
                    python /projects/0/ctdas/PARIS/STILT_CTEHR_scripts/fp_flux_mult/fp_flux_mult_singlerun.py --fluxtype $fluxtype --station $station --stationsfile $stationsfile --fluxdir $fluxdir --fpdir $fpdir --bgdir $bgdir --outdir $outdir --stiltdir $stiltdir --obspack_path $obspack_path --non_obspack_path $non_obspack_path --start_date $start_date --end_date $end_date --lat_ll $lat_ll --lat_ur $lat_ur --lon_ll $lon_ll --lon_ur $lon_ur --lat_step $lat_step --lon_step $lon_step --sim_len $sim_len --perturbation $perturbation >> ${LOGFILE} 2>&1 & # Run your executable, note the "&"
                    echo "option 4"
            fi
    fi
done
wait $!
echo
echo "All footprint-flux multiplications are done."
grep -r "Flux multiplication finished for station*" ${LOGFILE} | wc -l
echo "Total: {$N_LINES}"
