#!/bin/bash
#FLUX: --job-name=fenics-cube
#FLUX: -N=4
#FLUX: -n=96
#FLUX: --queue=thinnodes
#FLUX: -t=3600
#FLUX: --urgency=16

export ATP_ENABLED='1'

export ATP_ENABLED=1
set -e
cp mesh0.bin mesh.bin
M=24
MMAX=96
for i in $( seq -w 00 40 )
do
    # Run one adaptive iteration
    mkdir -p iter_${i}
    ( srun -n $M ./demo > log1 2> log2 < /dev/null )
    # Postprocess the solution into ParaView files
    srun -n 1 ./dolfin_post -m mesh_out.bin -t vtk -n 200 -s velocity -f 10  1> log.pp1 2> log.ppe1 &
    srun -n 1 ./dolfin_post -m mesh_out.bin -t vtk -n 1000 -s dvelocity -f 10  1> log.pp2 2> log.ppe2 &
    srun -n 1 ./dolfin_post -m mesh_out.bin -t vtk -n 1000 -s pressure -f 10 1> log.pp3 2> log.ppe3 &
    srun -n 1 ./dolfin_post -m mesh_out.bin -t vtk -n 1000 -s dpressure -f 10 1> log.pp4 2> log.ppe4 &
    wait
    # Prepare for the next adaptive iteration
    mv *.bin log1 log2 *.vtu *.pvd iter_${i}
    cp iter_${i}/rmesh.bin iter_${i}/mesh0.bin iter_${i}/log1 .
    cp rmesh.bin mesh.bin
    # Compute new core count
    M=$(( $( tail -n 10 log1|grep "vertices after"|cut -d " " -f 3 ) / 250 ))
    M=$(( $M < 24 ? 24 : $M ))
    M=$(( $M > $MMAX ? $MMAX : $M ))
done
