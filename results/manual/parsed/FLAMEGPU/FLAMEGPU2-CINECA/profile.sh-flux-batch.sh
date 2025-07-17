#!/bin/bash
#FLUX: --job-name=adorable-lizard-1268
#FLUX: -c=2
#FLUX: --exclusive
#FLUX: --queue=m100_usr_prod
#FLUX: -t=2700
#FLUX: --urgency=16

rm -rf /tmp/nvidia
ln -s $TMPDIR /tmp/nvidia
module load cuda/11.0
module load hpc-sdk/2021--binary
cd build/bin/Release
nsys profile --force-overwrite true -o f2-boids-s3d-163k-s5 boids_spatial3D -s 5 -r 12
ncu --set full --force-overwrite -o f2-boids-s3d-163k-s5 boids_spatial3D -s 5 -r 12
nsys profile --force-overwrite true -o f2-boids-rtc-s3d-163k-s5 boids_rtc_spatial3D -s 5 -r 12
ncu --set full --force-overwrite -o f2-boids-rtc-s3d-163k-s5 boids_rtc_spatial3D -s 5 -r 12
nsys profile --force-overwrite true -o f2-boids-bf-163k-s5 boids_bruteforce -s 5 -r 12
ncu --set full --force-overwrite -o f2-boids-bf-163k-s5 boids_bruteforce -s 5 -r 12
nsys profile --force-overwrite true -o f2-boids-rtc-bf-163k-s5 boids_rtc_bruteforce -s 5 -r 12
ncu --set full --force-overwrite -o f2-boids-rtc-bf-163k-s5 boids_rtc_bruteforce -s 5 -r 12
rm -rf /tmp/nvidia
