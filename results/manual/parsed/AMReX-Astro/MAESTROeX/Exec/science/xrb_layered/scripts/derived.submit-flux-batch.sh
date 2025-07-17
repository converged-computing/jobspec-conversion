#!/bin/bash
#FLUX: --job-name=goodbye-caramel-8567
#FLUX: -t=7200
#FLUX: --urgency=16

RUN_DIR=$1
echo $RUN_DIR
PLOT_DIR=PLOTS
PLOT_BASENAME="*xrb_" # includes the smallplot files
script=~/MAESTROeX/Exec/science/xrb_layered/plotfile_derive/derive2d.gnu.x86-milan.ex
cd $RUN_DIR
plots=()
for plotfile in $PLOT_DIR/$PLOT_BASENAME*; do
    [[ ! -d "$plotfile" ]] && continue
    [[ "$plotfile" == *.old.* ]] && continue
    [[ -e "$plotfile/derived" ]] && continue
    plots+=($plotfile)
done
N0=${#plots[@]}
echo $N0" plotfiles to process"
if [ $N0 -eq 0 ]; then
    exit 0
fi
if [ -n "$SLURM_JOB_ID" ]; then
    module load parallel
    NTASK=32
    echo "Running in parallel with "$NTASK" processes"
    # Temporary text file with all of the plotfiles
    tmpfile=$(mktemp)
    printf "%s\n" "${plots[@]}" > "$tmpfile"
    # Use srun parallel as in the "Running Many Tasks Inside a Single Node Allocation" example here
    # https://docs.nersc.gov/jobs/workflow/gnuparallel/
    srun parallel --jobs $NTASK "$script diag.plotfile={}" :::: "$tmpfile"
    rm -f "$tmpfile"
else
    for ((i=0; i<$N0; i++)); do
        plotfile="${plots[$i]}"
        #echo "Processing: $plotfile"
        $script diag.plotfile=$plotfile
        # Print the number of remaining plotfiles
        remaining=$((N0 - i - 1))
        echo $remaining
    done
fi
echo "done"
