#!/bin/bash
#FLUX: --job-name=hello-knife-4695
#FLUX: --urgency=16

SPLIT=10000  # Size of job chunks
ROOT=/asap3/petra3/gpfs/p09/2023/data/11016752/processed/rodria
INPUT=$1
RUN=$(sed 's/.lst//g'<<<$(basename $INPUT))
GEOM=${ROOT}/calib/eiger4m_v2.geom
STREAMDIR=${ROOT}/indexing/streams
ERRORDIR=${ROOT}/error
PDB=${ROOT}/pdb/lasv_apo.cell
source /etc/profile.d/modules.sh
module load xray
module load maxwell crystfel/0.10.2
module load hdf5/1.10.5
for FILE1 in $(cat $INPUT); do
    RUN=$(sed 's/.h5//g'<<<$(basename $FILE1))
    echo $RUN
    echo $FILE1 > tmp.lst
    list_events -i tmp.lst -g $GEOM -o events-${RUN}.lst
    split -a 3 -d -l $SPLIT events-${RUN}.lst split-events-${RUN}.lst
    rm -f events-${RUN}.lst
    rm -f tmp.lst
  for FILE in split-events-${RUN}.lst*; do
    # Stream file is the output of crystfel
    STREAM=`echo $FILE | sed -e "s/split-events-${RUN}.lst/${RUN}.stream/"`
    # Job name
    NAME=`echo $FILE | sed -e "s/split-events-${RUN}.lst/${RUN}-/"`
    # Job number
    NUMBER=${NAME##$RUN-}
    POS=`expr $NUMBER \* $SPLIT + 1`
    echo "$NAME (serial start $POS): $FILE  --->  $STREAM"
    SLURMFILE="${NAME}.sh"
    echo "#!/bin/sh" > $SLURMFILE
    echo >> $SLURMFILE
    echo "#SBATCH --partition=upex,cfel,cfel-cdi" >> $SLURMFILE  # Set your partition here
    echo "#SBATCH --time=4:00:00" >> $SLURMFILE
    echo "#SBATCH --nodes=1" >> $SLURMFILE
    echo "#SBATCH --nice=100" >> $SLURMFILE
    echo >> $SLURMFILE
    echo "#SBATCH --job-name  $NAME" >> $SLURMFILE
    echo "#SBATCH --output    $ERRORDIR/$NAME-%N-%j.out" >> $SLURMFILE
    echo "#SBATCH --error     $ERRORDIR/$NAME-%N-%j.err" >> $SLURMFILE
    echo >> $SLURMFILE
    echo "source /etc/profile.d/modules.sh" >> $SLURMFILE
    echo "module load xray" >> $SLURMFILE
    echo "module load hdf5-openmpi/1.10.5" >> $SLURMFILE
    echo "module load maxwell crystfel/0.10.2" >> $SLURMFILE
	echo "module load hdf5/1.10.5" >> $SLURMFILE
    echo "indexamajig --version" >> $SLURMFILE
    echo >> $SLURMFILE
    command="indexamajig -i $FILE -o $STREAMDIR/$STREAM"
    command="$command -j 80 -g $GEOM --int-radius=3,6,8"
    command="$command --peaks=peakfinder8 --min-snr=7.0 --min-res=0 --max-res=400 --threshold=0 --min-pix-count=1 --max-pix-count=200 --min-peaks=20 --local-bg-radius=3"
    #command="$command --peaks=peakfinder8 --min-snr=8 --min-res=10 --max-res=2000 --threshold=5 --min-pix-count=1 --max-pix-count=50 --min-peaks=20 --local-bg-radius=3"
    #command="$command --indexing=xgandalf --multi -p $PDB"
    #command="$command --indexing=mosflm --multi -p $PDB"
    #command="$command --indexing=mosflm-latt-nocell --multi"
    #command="$command --indexing=none"
    command="$command --multi -p $PDB"
    echo $command >> $SLURMFILE
    sbatch $SLURMFILE
  done
done
