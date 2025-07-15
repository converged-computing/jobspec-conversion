#!/bin/bash
#FLUX: --job-name=delicious-nalgas-5909
#FLUX: --urgency=16

OFFSET=0
LINE_NUM=$(echo "$SLURM_ARRAY_TASK_ID + $OFFSET" | bc)
outdir='scan_hx_hy_theta0_nc3000-hill'
line=$(sed -n "$LINE_NUM"p $outdir/scan_hx_hy.txt)
echo "Offset $OFFSET ; Line $LINE_NUM"
theta_x=$(echo "$line" | cut -d "," -f 1)
theta_y=$(echo "$line" | cut -d "," -f 2)
h_x=$(echo "$line" | cut -d "," -f 3)
h_y=$(echo "$line" | cut -d "," -f 4)
log10nc_x=$(echo "$line" | cut -d "," -f 5)
log10nc_y=$(echo "$line" | cut -d "," -f 6)
g_x=1
g_y=1
HillH=3
matlab -r "ScalingTwocellHillCommandline_diff_params('$outdir', $theta_x, $theta_y, $g_x, $g_y, $h_x, $h_y, $log10nc_x, $log10nc_y, $HillH) ; quit();"
