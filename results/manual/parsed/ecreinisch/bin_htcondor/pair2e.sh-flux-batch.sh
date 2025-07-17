#!/bin/bash
#FLUX: --job-name=fuzzy-avocado-8570
#FLUX: --urgency=16

if [ ! "$#" -eq 12 ]; then
	echo "$0 needs 12 arguments. Found only $#"
   	exit 1
fi
sat=${1}
ref=${2}
sec=${3}
satparam=${4}
demgrd=${5}
filter_wv=${6}
site=${7}
xmin=${8}
xmax=${9}
ymin=${10}
ymax=${11}
unwrap=${12}
if [[ "$sat" == "ERS2" || "$sat" == "ERS1" ]] ; then
	sat=ERS
fi
orb1a=`expr $ref - 1`
orb1b=`expr $ref + 1`
orb2a=`expr $ref - 1`
orb2b=`expr $ref + 1`
homedir=`pwd`
echo "Working directory homedir is $homedir"
if [ $# -gt 3 ] ; then
  case "$sat" in 
  ENVI)
    #cnf=$homedir/gmtsar/config/config.envi.txt
    cp $homedir/gmtsar/config/config.envi.txt .
    cnf=$homedir/config.envi.txt 
    ;;
  ERS)
    #cnf=$homedir/gmtsar/config/config.ers.txt
    cp $homedir/gmtsar/config/config.ers.txt .
    cnf=$homedir/config.ers.txt
    ;;
  ERS2)
    #cnf=$homedir/gmtsar/config/config.ers.txt
    cp $homedir/gmtsar/config/config.ers.txt .
    cnf=$homedir/config.ers.txt
    ;;
  ERS1)
    #cnf=$homedir/gmtsar/config/config.ers.txt
    cp $homedir/gmtsar/config/config.ers.txt .
    cnf=$homedir/config.ers.txt
    ;;
  ALOS)
    #cnf=$homedir/gmtsar/config/config.alos.txt
    cp $homedir/gmtsar/config/config.alos.txt .
    cnf=$homedir/config.alos.txt
    ;;
  TSX)
    #cnf=$homedir/gmtsar/config/config.tsx.txt
    # for htcondor
    #cp $homedir/gmtsar/config/config.tsx.txt .
    # for Askja
    cp /opt/gmtsar/6.0/share/gmtsar/csh/config.tsx.txt .
    cnf=$homedir/config.tsx.txt
    ;;
  S1A)
    #cnf=$homedir/gmtsar/config/config.s1a.txt
    cp $homedir/gmtsar/config/config.s1a.txt .
    cnf=$homedir/config.s1a.txt
    ;;
  S1B)
    cp $homedir/gmtsar/config/config.s1a.txt .
    cnf=$homedir/config.s1a.txt
    ;;
  *)
    echo "unknown sat $sat"
    exit 1
    ;;
  esac
else
  #cnf=$5
    cnf=$homedir/gmtsar/config/config.s1a.txt
    cp $homedir/gmtsar/config/config.s1a.txt .
    cnf=$homedir/config.s1a.txt
fi
echo "Config file cnf is $cnf"
if [ $# -ge 5 ] ; then
	sed -i "/filter_wavelength/c\filter_wavelength = $filter_wv" $cnf
	sed -i "/proc_stage/c\proc_stage = 1" $cnf
fi
echo "the unwrap variable is ${unwrap}"
echo "the config file is ${cnf}"
if [[ ${unwrap} != 0 ]]; then
	sed -i "/threshold_snaphu/c\threshold_snaphu = ${unwrap}" $cnf
	echo "setting the threshold_snaphu to ${unwrap}"
fi
RAWdir=../../RAW
pairdir=In${ref}_${sec}
if [ -d $pairdir ]; then
	echo "removing existing pairdir named $pairdir"
   	rm -rf $pairdir
fi
mkdir $pairdir
cd $pairdir
cp $cnf .
cnf=`basename $cnf`
echo "Configuration filename cnf is $cnf"
mkdir raw intf SLC topo
cd topo
ln -s ../../$demgrd dem.grd #this broke when moving files up and out $DOY directory -- SAB 06/30/21
cd ..
cd raw
if [ "$sat" == "ENVI" ] ; then
	cp $RAWdir/$2.* .
	cp $RAWdir/$3.* .
	mv ../../orbits .
elif [[ "$sat" == "ERS"* ]] ; then
	cp $RAWdir/$2.* .
	cp $RAWdir/$3.* .
	mv ../../orbits .
elif [ "$sat" == "ALOS" ] ; then
	cp $RAWdir/IMG*$2* .
	cp $RAWdir/LED*$2* .
	cp $RAWdir/IMG*$3* .
	cp $RAWdir/LED*$3* .
	# cp $RAWdir/IMG*$2* .
	# cp $RAWdir/IMG*$3* .
elif [ "$sat" == "TSX" ] ; then
    # copy the files we want to keep in the tar file
	# cp -v $RAWdir/${ref}.PRM .
	# cp -v $RAWdir/${sec}.PRM .
	# cp -v $RAWdir/${ref}.LED .
	# cp -v $RAWdir/${sec}.LED .
    # # make links for some files
	# ln -s $RAWdir/${ref}.LED ${ref}.LED
	# ln -s $RAWdir/${sec}.LED ${sec}.LED
    # these get deleted in step 1, but they must be there
	#ln -s $RAWdir/${ref}.SLC ${ref}.SLC
	#ln -s $RAWdir/${sec}.SLC ${sec}.SLC
	touch ${ref}.SLC
	touch ${sec}.SLC
	touch ${ref}.PRM
	touch ${sec}.PRM
	touch ${ref}.LED
	touch ${sec}.LED
	longdirname1=`grep ${site} /s12/insar/TSX/TSX_OrderList.txt | grep ${ref} | awk '{print $12}'`
	echo "longdirname1 is $longdirname1"
	longbasename1=`basename $longdirname1`
	echo "longbasename is $longbasename1"
	longdirname2=`grep ${site} /s12/insar/TSX/TSX_OrderList.txt | grep ${sec} | awk '{print $12}'`
	echo "longdirname2 is $longdirname2"
	longbasename2=`basename $longdirname2`
	echo "longbasename2 is $longbasename2"
	# copy the whole thing
	cp -rv $RAWdir/$longbasename1 .
	cp -rv $RAWdir/$longbasename2 .
	# links for $ref and $sec .cos and .xml with date names for rsynced earlier run_pair_gmtsarv60.sh
	#XMLref=`find $RAWdir/TDX1_SM_091_strip_005_20201023014507 -name "*.xml" | grep -v ANNOTATION | grep -v iif`
	#XMLref=`find $RAWdir/$longbasename1 -name "*.xml" | grep -v ANNOTATION | grep -v iif`
	XMLref=`find $longbasename1 -name "*.xml" | grep -v ANNOTATION | grep -v iif`
	ln -s $XMLref ${ref}.xml
	#cp -v $XMLref ${ref}.xml
	#COSref=`find $RAWdir/TDX1_SM_091_strip_005_20201023014507 -name "*.cos"`
	#COSref=`find $RAWdir/$longbasename1 -name "*.cos"`
	COSref=`find $longbasename1 -name "*.cos"`
	ln -s $COSref ${ref}.cos
	#cp -v $COSref ${ref}.cos
	#XMLsec=`find $RAWdir/TDX1_SM_091_strip_005_20201114014508 -name "*.xml" | grep -v ANNOTATION | grep -v iif`
	#XMLsec=`find $RAWdir/$longbasename2 -name "*.xml" | grep -v ANNOTATION | grep -v iif`
	XMLsec=`find $longbasename2 -name "*.xml" | grep -v ANNOTATION | grep -v iif`
	ln -s $XMLsec ${sec}.xml
    #cp -v $XMLsec ${sec}.xml
	#COSsec=`find $RAWdir/TDX1_SM_091_strip_005_20201114014508 -name "*.cos"`
	#COSsec=`find $RAWdir/$longbasename2 -name "*.cos"`
	COSsec=`find $longbasename2 -name "*.cos"`
	ln -s $COSsec ${sec}.cos
    #cp -v $COSsec ${sec}.cos
elif [[ "$sat" == "S1"* ]] ; then
	subswath=$satparam
	ln -s $RAWdir/${sat}*${2}_${subswath}.* .
	ln -s $RAWdir/${sat}*${3}_${subswath}.* .
	##  ln -s $RAWdir/S1A*$2*.SAFE/annotation/*.xml .
	##  ln -s $RAWdir/S1A*$2*.SAFE/measurement/*.tiff .
	##  ln -s $RAWdir/S1A*$3*.SAFE/annotation/*.xml .
	##  ln -s $RAWdir/S1A*$3*.SAFE/measurement/*.tiff .
	## ln -s $RAWdir/S1A*$2*.xml .
	##  ln -s $RAWdir/S1A*$2*.tiff .
	##  ln -s $RAWdir/S1A*$3*.xml .
	##  ln -s $RAWdir/S1A*$3*.tiff .
	##  ln -s $RAWdir/S1A*$orb1a*.EOF .
	##  ln -s $RAWdir/S1A*$orb2a*.EOF .
	#  ln -s $RAWdir/*.xml .
	#  ln -s $RAWdir/*.tiff .
	#  ln -s $RAWdir/*.xml .
	#  ln -s $RAWdir/*.tiff .
	#  ln -s $RAWdir/*.EOF .
	#  ln -s $RAWdir/*.EOF .
	#  orb1=`ls S1A*$orb1a*.EOF`
	#  orb2=`ls S1A*$orb2a*.EOF` 
	#  orb1=`ls S1A*$orb1a*.EOF`
	#  orb2=`ls S1A*$orb2a*.EOF`
	#ln -s ../../$demgrd .
	## refdir=`ls S1A*$2*.xml | awk -F1.xml '{print $1}'`
	## secdir=`ls S1A*$3*.xml | awk -F1.xml '{print $1}'`
	##echo $refdir
	##echo $secdir
	#echo "PASS"
else
	echo "unknown sat $sat"
	exit 1
fi
cd ..
echo '#!/bin/bash -vx' > run.sh
if [[ "$sat" == "ALOS" ]] ; then
	ref=`ls -l raw/IMG-HH-*${ref}* | awk -Fraw/ '{print $2}' | head -1`
	sec=`ls -l raw/IMG-HH-*${sec}* | awk -Fraw/ '{print $2}' | head -1`
fi
 # cd raw
 # echo "cd raw" >> ../run.sh
 # for i in 1 ; do a=`basename *$ref*$i.xml .xml`; b=`basename *$sec*$i.xml .xml`; echo align_tops.csh $a $orb1 $b $orb2 `echo $demgrd | awk -F/ '{print $2}'` >> ../run.sh; done
 # echo "cd .." >> ../run.sh
 # cd ..
  #echo "mkdir F1 F2 F3
echo SAT = $sat
if [[ "$sat" == "TSX" ]] ; then
	if [[ "$site" == "dcamp" || "$site" == "tungs" || "$site" == "dixie" || "$site" == "tusca" ]] ; then #special case for Airbus not urgent
		echo "USING AIRBUS VERSION OF P2P FOR TSX"
		echo p2p_TSX_SLC_airbus.csh $ref $sec $cnf >> run.sh
  	else
		#this script is now p2p_processing.csh  
		#echo p2p_TSX_SLC.csh $ref $sec $cnf >> run.sh
		# standard out of the box version
		echo p2p_processing.csh ${sat} ${ref} ${sec} ${cnf} >> run.sh
		# Kurt's modified version
     	#echo p2p_processingKF.csh ${sat} $ref $sec $cnf >> run.sh
	fi
elif [[ "$sat" == "S1"* ]] ; then
	echo p2p_S1A_TOPS.csh ${sat}${ref}_${subswath} ${sat}${sec}_${subswath} $cnf >> run.sh
elif [[ "$sat" == "ALOS" ]] ; then
	if [[ $ref == *"1.1"* ]] ; then
		echo $ref $sec
		echo p2p_ALOS2_SLC.csh $ref $sec $cnf >> run.sh
	else
		echo p2p_ALOS.csh $ref $sec $cnf >> run.sh
	fi
else
    echo p2p_$sat.csh $ref $sec $cnf >> run.sh
fi
chmod +x run.sh
echo "print working directory:"
pwd
echo "Leaving pair2e.sh and returning to run_pair_gmtsarv60.sh.  If not run automatically, consider running the following command"
echo "cd $pairdir; ./run.sh"
