#!/bin/bash
#SBATCH --account=tra21_hackathon
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=10000MB
#SBATCH --time=00:45:00
#SBATCH --partition=m100_usr_prod
#SBATCH --qos=m100_qos_dbg
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1,ntasks-per-socket=1

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
