#!/bin/bash
#FLUX: --job-name=Opensees
#FLUX: --queue=express
#FLUX: -t=300
#FLUX: --priority=16

module load python   
module load opensees/3.2.0
module load parallel
python run_opensees_UQpy.py       
