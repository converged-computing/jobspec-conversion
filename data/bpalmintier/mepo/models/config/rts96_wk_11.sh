#!/bin/bash
#
# =======  TEMPLATE GAMS-CPLEX Header ========
#    No printf parameters
#
# Simple BASH script to run and time a series of GAMS jobs to compare the run
# time of binary vs clustered unit commitment both with and without capacity
# expansion decisions
#
# To actually submit the job use:
#   qsub SCRIPT_NAME

#  Version History
# Ver   Date       Time  Who            What
# ---  ----------  ----- -------------- ---------------------------------
#   1  2011-10-08  04:20  bpalmintier   Adapted from pbs_time1.sh v4
#   2  2011-10-08  21:00  bpalmintier   Implemented use of scratch space

#========= Setup Job Queue Parameters ==========
# IMPORTANT: The lines beginning #PBS set various queuing parameters, they are not simple comments
#
# name of submitted job, also name of output file unless specified
# The default job name is the name of this script, so here we surpress the job naming so
# we get unique names for all of our jobs
##PBS -N matlab_pbs
#
# Ask for all 1 node with 8 processors. this may or may not give
# exclusive access to a machine, but typically the queueing system will
# assign the 8 core machines first
#
# By requiring 20GB we ensure we get one of the machines with 24GB (or maybe a 12 core unit)
#PBS -l nodes=1:ppn=8,mem=20gb
#
# This option merges any error messages into output file
#PBS -j oe 
#
# Select the queue based on maximum run times. options are:
#    short    2hr
#    medium   8hr
#    long    24hr
#    xlong   48hr, extendable to 168hr using -l walltime= option below
#PBS -q long
# And up the run time to the maximum of a full week (168 hrs)
##PBS -l walltime=168:00:00

echo "Node list:"
cat  $PBS_NODEFILE

echo "Disk usage:"
df -h

#Set things up to load modules
source /etc/profile.d/modules.sh

#Load recent version of GAMS
module load gams/23.6.3

#Set path to gams in environment variable so MATLAB can read it
GAMS=`which gams`
export GAMS

#And load CPLEX
module load cplex

#Establish a working directory in scratch
#Will give error if it already exists, but script continues anyway
mkdir /scratch/b_p

#Clean anything out of our scratch folder (Assumes exclusive machine usage)
rm -r /scratch/b_p/*

#Make a new subfolder for this job
SCRATCH="/scratch/b_p/${PBS_JOBID}"
mkdir $SCRATCH

#Establish our model directory
MODEL_DIR="${HOME}/projects/advpower/models/ops/"

#----------------------------
# Setup gams options
#----------------------------
DATE_TIME=`date +%y%m%d-%H%M`
ADVPOWER_REPO_VER=`svnversion ~/projects/advpower`
echo "Date & Time:" ${DATE_TIME}
echo "SVN Repository Version:" ${ADVPOWER_REPO_VER}

GAMS_MODEL="UnitCommit"

#=== END HEADER ===

#======= Repeated GAMS running Template =======
# Template requires 4 (printf style) substitutions:
#     string     output directory
#     string     run_id
#     string     gams_extra_options
#     string     background task

#  Version History
# Ver   Date       Time  Who            What
# ---  ----------  ----- -------------- ---------------------------------
#   1  2011-10-08  04:20  bpalmintier   Adapted from pbs_time1.sh v4
#   2  2011-10-08  21:00  bpalmintier   Implemented use of scratch space
#   3  2011-11-03  03:50  bpalmintier   Added Svante job to memo

OUT_DIR="${HOME}/projects/advpower/models/ops/out/rts96_1week_1x/"
#Make sure output directory exists
mkdir ${OUT_DIR}

RUN_CODE="RTS_x1_wk_sep_ud_comRsv_m01"

#Make a temporary run directory in scratch
WORK_DIR="${SCRATCH}/tmp_${RUN_CODE}/"
mkdir ${WORK_DIR}
cp ${MODEL_DIR}${GAMS_MODEL}.gms   ${WORK_DIR}
cd ${WORK_DIR}

echo "${GAMS_MODEL} copied to temporary ${WORK_DIR}"
pwd

# Default GAMS options to:
#   errmsg:     enable in-line description of errors in list file
#   lf & lo:    store the solver log (normally printed to screen) in $OUT_DIR
#   o:          rename the list file and store in $OUT_DIR
#   inputdir:   Look for $include and $batinclude files in $WORK_DIR
# And Advanced Power Model options to:
#   out_dir:    specify directory for CSV output files 
#   out_prefix: add a unique run_id to all output files
#   memo:       encode some helpful run information in the summary file
#
# Plus additional user supplied options pasted into template
GAMS_OPTIONS="-errmsg=1 -lf=${OUT_DIR}${RUN_CODE}_${GAMS_MODEL}.log -lo=2 -o=${OUT_DIR}${RUN_CODE}_${GAMS_MODEL}.lst -inputdir=${MODEL_DIR} --out_dir=${OUT_DIR} --out_prefix=${RUN_CODE}_ --memo=${RUN_CODE}_run_time_compare_${RUN_CODE}_v${ADVPOWER_REPO_VER}_${DATE_TIME}     --no_nse=1 --par_threads=1 --startup=1 --ramp=1 --out_gen_params=1 --max_solve_time=36000 --sys=ieee_rts96_sys.inc --gens=ieee_rts96_gens_sepunit.inc --demand=ieee_rts96_dem_wk.inc --demscale=0.92 --min_up_down=1 --rsrv=flex --pwl_cost=1 --mip_gap=0.001 "

#Now run GAMS-CPLEX
echo "Running ${GAMS_MODEL} using GAMS"
echo "  Options: ${GAMS_OPTIONS}"
echo .
gams ${GAMS_MODEL} ${GAMS_OPTIONS} &
echo "GAMS Done (${RUN_CODE})"
echo .

cd ${MODEL_DIR}
pwd


#======= Repeated GAMS running Template =======
# Template requires 4 (printf style) substitutions:
#     string     output directory
#     string     run_id
#     string     gams_extra_options
#     string     background task

#  Version History
# Ver   Date       Time  Who            What
# ---  ----------  ----- -------------- ---------------------------------
#   1  2011-10-08  04:20  bpalmintier   Adapted from pbs_time1.sh v4
#   2  2011-10-08  21:00  bpalmintier   Implemented use of scratch space
#   3  2011-11-03  03:50  bpalmintier   Added Svante job to memo

OUT_DIR="${HOME}/projects/advpower/models/ops/out/rts96_1week_1x/"
#Make sure output directory exists
mkdir ${OUT_DIR}

RUN_CODE="RTS_x1_wk_clust_ud_m01_maxS"

#Make a temporary run directory in scratch
WORK_DIR="${SCRATCH}/tmp_${RUN_CODE}/"
mkdir ${WORK_DIR}
cp ${MODEL_DIR}${GAMS_MODEL}.gms   ${WORK_DIR}
cd ${WORK_DIR}

echo "${GAMS_MODEL} copied to temporary ${WORK_DIR}"
pwd

# Default GAMS options to:
#   errmsg:     enable in-line description of errors in list file
#   lf & lo:    store the solver log (normally printed to screen) in $OUT_DIR
#   o:          rename the list file and store in $OUT_DIR
#   inputdir:   Look for $include and $batinclude files in $WORK_DIR
# And Advanced Power Model options to:
#   out_dir:    specify directory for CSV output files 
#   out_prefix: add a unique run_id to all output files
#   memo:       encode some helpful run information in the summary file
#
# Plus additional user supplied options pasted into template
GAMS_OPTIONS="-errmsg=1 -lf=${OUT_DIR}${RUN_CODE}_${GAMS_MODEL}.log -lo=2 -o=${OUT_DIR}${RUN_CODE}_${GAMS_MODEL}.lst -inputdir=${MODEL_DIR} --out_dir=${OUT_DIR} --out_prefix=${RUN_CODE}_ --memo=${RUN_CODE}_run_time_compare_${RUN_CODE}_v${ADVPOWER_REPO_VER}_${DATE_TIME}     --no_nse=1 --par_threads=1 --startup=1 --ramp=1 --out_gen_params=1 --max_solve_time=36000 --sys=ieee_rts96_sys.inc --gens=ieee_rts96_gens.inc --demand=ieee_rts96_dem_wk.inc --demscale=0.92 --min_up_down=1 --rsrv=separate --pwl_cost=1 --mip_gap=0.001  --max_start=1 "

#Now run GAMS-CPLEX
echo "Running ${GAMS_MODEL} using GAMS"
echo "  Options: ${GAMS_OPTIONS}"
echo .
gams ${GAMS_MODEL} ${GAMS_OPTIONS} &
echo "GAMS Done (${RUN_CODE})"
echo .

cd ${MODEL_DIR}
pwd


#======= Repeated GAMS running Template =======
# Template requires 4 (printf style) substitutions:
#     string     output directory
#     string     run_id
#     string     gams_extra_options
#     string     background task

#  Version History
# Ver   Date       Time  Who            What
# ---  ----------  ----- -------------- ---------------------------------
#   1  2011-10-08  04:20  bpalmintier   Adapted from pbs_time1.sh v4
#   2  2011-10-08  21:00  bpalmintier   Implemented use of scratch space
#   3  2011-11-03  03:50  bpalmintier   Added Svante job to memo

OUT_DIR="${HOME}/projects/advpower/models/ops/out/rts96_1week_1x/"
#Make sure output directory exists
mkdir ${OUT_DIR}

RUN_CODE="RTS_x1_wk_sep_ud_m01_maxS"

#Make a temporary run directory in scratch
WORK_DIR="${SCRATCH}/tmp_${RUN_CODE}/"
mkdir ${WORK_DIR}
cp ${MODEL_DIR}${GAMS_MODEL}.gms   ${WORK_DIR}
cd ${WORK_DIR}

echo "${GAMS_MODEL} copied to temporary ${WORK_DIR}"
pwd

# Default GAMS options to:
#   errmsg:     enable in-line description of errors in list file
#   lf & lo:    store the solver log (normally printed to screen) in $OUT_DIR
#   o:          rename the list file and store in $OUT_DIR
#   inputdir:   Look for $include and $batinclude files in $WORK_DIR
# And Advanced Power Model options to:
#   out_dir:    specify directory for CSV output files 
#   out_prefix: add a unique run_id to all output files
#   memo:       encode some helpful run information in the summary file
#
# Plus additional user supplied options pasted into template
GAMS_OPTIONS="-errmsg=1 -lf=${OUT_DIR}${RUN_CODE}_${GAMS_MODEL}.log -lo=2 -o=${OUT_DIR}${RUN_CODE}_${GAMS_MODEL}.lst -inputdir=${MODEL_DIR} --out_dir=${OUT_DIR} --out_prefix=${RUN_CODE}_ --memo=${RUN_CODE}_run_time_compare_${RUN_CODE}_v${ADVPOWER_REPO_VER}_${DATE_TIME}     --no_nse=1 --par_threads=1 --startup=1 --ramp=1 --out_gen_params=1 --max_solve_time=36000 --sys=ieee_rts96_sys.inc --gens=ieee_rts96_gens_sepunit.inc --demand=ieee_rts96_dem_wk.inc --demscale=0.92 --min_up_down=1 --rsrv=separate --pwl_cost=1 --mip_gap=0.001  --max_start=1 "

#Now run GAMS-CPLEX
echo "Running ${GAMS_MODEL} using GAMS"
echo "  Options: ${GAMS_OPTIONS}"
echo .
gams ${GAMS_MODEL} ${GAMS_OPTIONS} &
echo "GAMS Done (${RUN_CODE})"
echo .

cd ${MODEL_DIR}
pwd


#======= Repeated GAMS running Template =======
# Template requires 4 (printf style) substitutions:
#     string     output directory
#     string     run_id
#     string     gams_extra_options
#     string     background task

#  Version History
# Ver   Date       Time  Who            What
# ---  ----------  ----- -------------- ---------------------------------
#   1  2011-10-08  04:20  bpalmintier   Adapted from pbs_time1.sh v4
#   2  2011-10-08  21:00  bpalmintier   Implemented use of scratch space
#   3  2011-11-03  03:50  bpalmintier   Added Svante job to memo

OUT_DIR="${HOME}/projects/advpower/models/ops/out/rts96_1week_1x/"
#Make sure output directory exists
mkdir ${OUT_DIR}

RUN_CODE="RTS_x1_wk_clust_NOminUD_m01"

#Make a temporary run directory in scratch
WORK_DIR="${SCRATCH}/tmp_${RUN_CODE}/"
mkdir ${WORK_DIR}
cp ${MODEL_DIR}${GAMS_MODEL}.gms   ${WORK_DIR}
cd ${WORK_DIR}

echo "${GAMS_MODEL} copied to temporary ${WORK_DIR}"
pwd

# Default GAMS options to:
#   errmsg:     enable in-line description of errors in list file
#   lf & lo:    store the solver log (normally printed to screen) in $OUT_DIR
#   o:          rename the list file and store in $OUT_DIR
#   inputdir:   Look for $include and $batinclude files in $WORK_DIR
# And Advanced Power Model options to:
#   out_dir:    specify directory for CSV output files 
#   out_prefix: add a unique run_id to all output files
#   memo:       encode some helpful run information in the summary file
#
# Plus additional user supplied options pasted into template
GAMS_OPTIONS="-errmsg=1 -lf=${OUT_DIR}${RUN_CODE}_${GAMS_MODEL}.log -lo=2 -o=${OUT_DIR}${RUN_CODE}_${GAMS_MODEL}.lst -inputdir=${MODEL_DIR} --out_dir=${OUT_DIR} --out_prefix=${RUN_CODE}_ --memo=${RUN_CODE}_run_time_compare_${RUN_CODE}_v${ADVPOWER_REPO_VER}_${DATE_TIME}     --no_nse=1 --par_threads=1 --startup=1 --ramp=1 --out_gen_params=1 --max_solve_time=36000 --sys=ieee_rts96_sys.inc --gens=ieee_rts96_gens.inc --demand=ieee_rts96_dem_wk.inc --demscale=0.92 --rsrv=separate --pwl_cost=1 --mip_gap=0.001 "

#Now run GAMS-CPLEX
echo "Running ${GAMS_MODEL} using GAMS"
echo "  Options: ${GAMS_OPTIONS}"
echo .
gams ${GAMS_MODEL} ${GAMS_OPTIONS} &
echo "GAMS Done (${RUN_CODE})"
echo .

cd ${MODEL_DIR}
pwd


#======= Repeated GAMS running Template =======
# Template requires 4 (printf style) substitutions:
#     string     output directory
#     string     run_id
#     string     gams_extra_options
#     string     background task

#  Version History
# Ver   Date       Time  Who            What
# ---  ----------  ----- -------------- ---------------------------------
#   1  2011-10-08  04:20  bpalmintier   Adapted from pbs_time1.sh v4
#   2  2011-10-08  21:00  bpalmintier   Implemented use of scratch space
#   3  2011-11-03  03:50  bpalmintier   Added Svante job to memo

OUT_DIR="${HOME}/projects/advpower/models/ops/out/rts96_1week_1x/"
#Make sure output directory exists
mkdir ${OUT_DIR}

RUN_CODE="RTS_x1_wk_sep_NOminUD_m01"

#Make a temporary run directory in scratch
WORK_DIR="${SCRATCH}/tmp_${RUN_CODE}/"
mkdir ${WORK_DIR}
cp ${MODEL_DIR}${GAMS_MODEL}.gms   ${WORK_DIR}
cd ${WORK_DIR}

echo "${GAMS_MODEL} copied to temporary ${WORK_DIR}"
pwd

# Default GAMS options to:
#   errmsg:     enable in-line description of errors in list file
#   lf & lo:    store the solver log (normally printed to screen) in $OUT_DIR
#   o:          rename the list file and store in $OUT_DIR
#   inputdir:   Look for $include and $batinclude files in $WORK_DIR
# And Advanced Power Model options to:
#   out_dir:    specify directory for CSV output files 
#   out_prefix: add a unique run_id to all output files
#   memo:       encode some helpful run information in the summary file
#
# Plus additional user supplied options pasted into template
GAMS_OPTIONS="-errmsg=1 -lf=${OUT_DIR}${RUN_CODE}_${GAMS_MODEL}.log -lo=2 -o=${OUT_DIR}${RUN_CODE}_${GAMS_MODEL}.lst -inputdir=${MODEL_DIR} --out_dir=${OUT_DIR} --out_prefix=${RUN_CODE}_ --memo=${RUN_CODE}_run_time_compare_${RUN_CODE}_v${ADVPOWER_REPO_VER}_${DATE_TIME}     --no_nse=1 --par_threads=1 --startup=1 --ramp=1 --out_gen_params=1 --max_solve_time=36000 --sys=ieee_rts96_sys.inc --gens=ieee_rts96_gens_sepunit.inc --demand=ieee_rts96_dem_wk.inc --demscale=0.92 --rsrv=separate --pwl_cost=1 --mip_gap=0.001 "

#Now run GAMS-CPLEX
echo "Running ${GAMS_MODEL} using GAMS"
echo "  Options: ${GAMS_OPTIONS}"
echo .
gams ${GAMS_MODEL} ${GAMS_OPTIONS} &
echo "GAMS Done (${RUN_CODE})"
echo .

cd ${MODEL_DIR}
pwd


#=== Footer Template ====
#  No printf parameters

#  Version History
# Ver   Date       Time  Who            What
# ---  ----------  ----- -------------- ---------------------------------
#   1  2011-10-08  04:20  bpalmintier   Adapted from pbs_time1.sh v4
#   2  2011-10-08  21:00  bpalmintier   Implemented use of scratch space

#Wait until all background jobs are complete
wait

#See how much disk space we used
df -h

#Clean-up scratch space
echo "Cleaning up our Scratch Space"
cd
rm -r /scratch/b_p/*

df -h

echo "Script Complete ${PBS_JOBID}"

