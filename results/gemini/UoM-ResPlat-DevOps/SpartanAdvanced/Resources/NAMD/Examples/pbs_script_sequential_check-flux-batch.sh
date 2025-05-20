#!/bin/bash
#flux: -N 2
#flux: --account=VR0021
#flux: -t 15m                   # Equivalent to 0:15:0
#flux: --queue=sque             # Assuming 'sque' is a valid queue/partition in Flux
#flux: --output=JobLog/flux_job_%J.out  # Main script output
#flux: --error=JobLog/flux_job_%J.err   # Main script error

### - job basename (for file naming) ---------------------
job_base_name="_A2_aspirin_dock_prod_check_"
### --------------------------------------------------------------

# Using different variable names to avoid conflict with 'date' command
current_date_f=$(date +%F)
current_date_fhms=$(date +%F-%H.%M)

# Flux jobs typically start in the submission directory.
# cd $FLUX_SUBMIT_DIR # This is usually not needed but can be explicit.

# Ensure output directories exist
mkdir -p JobLog OutputText Errors OutputFiles RestartFiles

# Log Flux job information
# Note: $FLUX_JOB_ID is available inside the allocation
if [ -n "$FLUX_JOB_ID" ]; then
  flux job info $FLUX_JOB_ID > "JobLog/${current_date_fhms}${job_base_name}.flux_job_info.txt"
else
  echo "FLUX_JOB_ID not set, cannot log job info." > "JobLog/${current_date_fhms}${job_base_name}.flux_job_info.txt"
fi

module load namd-intel/2.7b3

### --------------------------------------------------------------------------
## optimize the original molecule
echo "Starting NAMD optimization: $(date)"
flux mini run namd2 aspirin_opt.conf > "OutputText/optimization.${current_date_f}.out" 2> "Errors/optimization.${current_date_f}.err"
echo "Finished NAMD optimization: $(date)"

# Check if optimization produced expected files before moving/copying
if [ -f *.dcd ]; then
    mv *.dcd OutputFiles/
else
    echo "Warning: No .dcd files found after optimization."
fi

# Copy restart files if they exist
for ext in coor vel xsc xst; do
    if [ -f "*.$ext" ]; then
        cp "*.$ext" RestartFiles/
    else
        echo "Warning: No .$ext files found to copy to RestartFiles after optimization."
    fi
done

## mv generic_optimization output to generic_restart files:
if [ -f "generic_optimization.restart.coor" ]; then
    mv generic_optimization.restart.coor generic_restartfile.restart.coor
else
    echo "Warning: generic_optimization.restart.coor not found."
fi
if [ -f "generic_optimization.restart.vel" ]; then
    mv generic_optimization.restart.vel  generic_restartfile.restart.vel
else
    echo "Warning: generic_optimization.restart.vel not found."
fi
if [ -f "generic_optimization.restart.xsc" ]; then
    mv generic_optimization.restart.xsc  generic_restartfile.restart.xsc
else
    echo "Warning: generic_optimization.restart.xsc not found."
fi

### start a loop ------------------------------------------------------------
for loop_count in {1..20}
do
  current_basename="${current_date_f}${job_base_name}${loop_count}"
  echo "Starting NAMD production run loop ${loop_count}: $(date)"

  ## run namd job:
  flux mini run namd2 aspirin_sequential_prod.conf > "OutputText/${current_basename}.out" 2> "Errors/${current_basename}.err"
  echo "Finished NAMD production run loop ${loop_count}: $(date)"

  ## rename output and move data into folders
  # This assumes aspirin_sequential_prod.conf writes to files named "generic_restartfile.*"
  if [ -f "generic_restartfile.dcd" ]; then
    cp generic_restartfile.dcd   "OutputFiles/${current_basename}.dcd"
  else
    echo "Warning: generic_restartfile.dcd not found for loop ${loop_count}."
  fi
  if [ -f "generic_restartfile.coor" ]; then
    cp generic_restartfile.coor  "RestartFiles/${current_basename}.restart.coor"
  else
    echo "Warning: generic_restartfile.coor not found for loop ${loop_count}."
  fi
  if [ -f "generic_restartfile.vel" ]; then
    cp generic_restartfile.vel   "RestartFiles/${current_basename}.restart.vel"
  else
    echo "Warning: generic_restartfile.vel not found for loop ${loop_count}."
  fi
  if [ -f "generic_restartfile.xsc" ]; then
    cp generic_restartfile.xsc   "RestartFiles/${current_basename}.restart.xsc"
  else
    echo "Warning: generic_restartfile.xsc not found for loop ${loop_count}."
  fi
  if [ -f "generic_restartfile.xst" ]; then
    cp generic_restartfile.xst   "RestartFiles/${current_basename}.xst"
  else
    echo "Warning: generic_restartfile.xst not found for loop ${loop_count}."
  fi
done
### --------------------------------------------------------------------------

## cleanup
echo "Starting cleanup: $(date)"
# Move FFTW files if they exist
if ls FFTW* 1> /dev/null 2>&1; then
    mv FFTW* OutputText/
else
    echo "No FFTW* files to move."
fi

# Remove intermediate and temporary files, -f suppresses errors if files don't exist
rm -f *.BAK *.old *.coor *.vel *.xsc *.xst

# The main script's stdout/stderr are handled by #flux: --output and #flux: --error directives.
# So, the original 'mv pbs_*.e* JobLog/' and 'mv pbs_*.o* JobLog/' are not needed.

echo "Cleanup finished: $(date)"
echo "Job completed successfully."