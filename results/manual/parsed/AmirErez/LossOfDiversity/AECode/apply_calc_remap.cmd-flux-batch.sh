#!/bin/bash
#FLUX: --job-name=blue-nunchucks-8775
#FLUX: --priority=16

OFFSET=1
LINE_NUM=$(echo "$SLURM_ARRAY_TASK_ID + $OFFSET" | bc)
rundir='remap_m2_alphas_c0s_try4';
outdir="../Data/Raw/${rundir}"
readfile="$outdir/remap_to_run.csv"
if [ ! -e $readfile ]; then
   echo "Error! File $readfile does not exist!"
   exit 1
fi
line=$(sed -n "$LINE_NUM"p $readfile)
index=$(echo "$line" | cut -d "," -f 1)
log10c0=$(echo "$line" | cut -d "," -f 2)
alpha_val=$(echo "$line" | cut -d "," -f 3)
p_str=$(echo "$line" | cut -d "," -f 4)
alpha_str=$(echo "$line" | cut -d "," -f 5)
outfile=$(echo "$line" | cut -d "," -f 6)
echo "Offset $OFFSET ; Line $LINE_NUM ; log10c0 $log10c0 ; P $p_str ; alpha $alpha_str ; outfile $outfile"
matlab -nojvm -r "load('$outdir/remapping_params.mat'); \
           params.log10c0 = $log10c0; \
           params.P = eval('$p_str'); \
           params.P = params.P'; \
           params.alpha = eval('$alpha_str');\
           params.alpha_val = params.alpha(1,1);\
           disp('A serial dilution simulation is starting...'); \
           remapped_P = find_remapping_twonut(params);\
           params.P = remapped_P; \
           output = exec_serialdil(params); \
           save('$outdir/$outfile', 'params', 'output', 'remapped_P'); \
           disp('Finished! Saved to $outdir/$outfile'); \
           quit();"
exit $?
