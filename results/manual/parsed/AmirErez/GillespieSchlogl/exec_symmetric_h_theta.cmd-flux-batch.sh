#!/bin/bash
#FLUX: --job-name=lovable-bits-5851
#FLUX: --priority=16

OFFSET=2000
LINE_NUM=$(echo "$SLURM_ARRAY_TASK_ID + $OFFSET" | bc)
outdir='symmetric_h_theta_nc3000'
mkdir -p $outdir
line=$(sed -n "$LINE_NUM"p $outdir/symmetric_h_theta.txt)
echo "Offset $OFFSET ; Line $LINE_NUM"
theta_x=$(echo "$line" | cut -d "," -f 1)
theta_y=$(echo "$line" | cut -d "," -f 2)
h_x=$(echo "$line" | cut -d "," -f 3)
h_y=$(echo "$line" | cut -d "," -f 4)
log10nc_x=$(echo "$line" | cut -d "," -f 5)
log10nc_y=$(echo "$line" | cut -d "," -f 6)
g_x=1
g_y=1
matlab -r "ScalingTwocellSchloglCommandline_diff_params('$outdir', $theta_x, $theta_y, $g_x, $g_y, $h_x, $h_y, $log10nc_x, $log10nc_y) ; quit();"
