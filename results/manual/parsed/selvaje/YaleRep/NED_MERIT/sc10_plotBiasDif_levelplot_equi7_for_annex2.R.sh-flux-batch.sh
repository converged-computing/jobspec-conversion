#!/bin/bash
#FLUX: --job-name=arid-itch-7249
#FLUX: --urgency=16

module load R/3.4.4-foss-2018a-X11-20180131  # new path 
cd /gpfs/loomis/project/fas/sbsc/ga254/dataproces/NED_MERIT/
R  --vanilla --no-readline   -q  <<EOF
rm(list = ls())
library(rgdal)
library(raster)
library(ggplot2)
library(gridExtra)
e = extent ( 6890000 , 6910000 ,  5200000 , 5218400 ) 
elev_M = raster ("/gpfs/loomis/project/fas/sbsc/ga254/dataproces/MERIT/equi7/dem/NA/NA_066_048.tif") 
elev_M = crop   (elev_M , e)
elev_M
elev_N = raster ("/gpfs/loomis/project/fas/sbsc/ga254/dataproces/NED/input_tif/NA_066_048.tif") 
elev_N = crop   (elev_N , e)
elev_N
elev_dif = elev_N - elev_M
for ( dir in c("elevation","roughness","tri","tpi","vrm","cti","spi","slope","pcurv","tcurv","dx","dy","dxx","dyy","dxy","convergence","aspectcosine","aspectsine","eastness","northness")) { 
     raster  <- raster(paste0( dir,"/tiles/","/NA_066_048_bias_msk.tif") ) 
     raster = crop (raster , e)
     raster[raster == -9999 ] <- NA
 assign(paste0(dir) , raster  )
}
summary(elevation)
print("start to plot")
n=100
colR=colorRampPalette(c("blue","green","yellow", "orange" , "red", "brown", "black" ))
cols=colR(n)
options(scipen=10)
trunc <- function(x, ..., prec = 0) base::trunc(x * 10^prec, ...) / 10^prec
pdf(paste0("/gpfs/loomis/project/fas/sbsc/ga254/dataproces/NED_MERIT/figure/BiasDif_all_var_plot_equi7_for_annex2.pdf") , width=6, height=7.5   )
par (oma=c(2,2,2,1) , mar=c(0.4,0.5,1,1.9) , cex.lab=0.5 , cex=0.6 , cex.axis=0.4  ,   mfrow=c(6,4) ,  xpd=NA    )
for ( dir in c("elev_N","elev_M","elev_cor","elev_dif","elevation","roughness","tri","tpi","vrm","cti","spi","aspectcosine","aspectsine","slope","eastness","northness","pcurv","tcurv","dx","dy","dxx","dyy","dxy","convergence")) { 
if ( dir != "elev_cor" ) { 
raster=get(dir)
if(dir == "elev_N"   ) { des="Elevation 3DEP"  ;  max=elev_N@data@max ; min=elev_N@data@min ; at=c( round(min)+10, round(max)-10);labels=c( round(min),round(max) ) ; letter="b" }
if(dir == "elev_N"   ) { des="Elevation 3DEP"  ; maxN=elev_N@data@max ; minN=elev_N@data@min    }
if(dir == "elev_M"   ) { des="Elevation MERIT" ; max=elev_M@data@max ; min=elev_M@data@min ; at=c( round(min)+10, round(max)-10);labels=c( round(min),round(max) ) ; letter="a" }
if(dir == "elev_M"   ) { des="Elevation MERIT" ; maxM=elev_M@data@max ; minM=elev_M@data@min  }
if(dir == "elev_dif" ) { des="Elevation diff. 3DEP - MERIT" ; max=round(elev_dif@data@max) ; min=round(elev_dif@data@min) ; at=c( min,0,max); labels=c(min,0 ,  max ) ; letter="d" }
if(dir == "elevation" )  { des="Elevation"                ; max=100 ; min=-100 ;  at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="e" ;  }
if(dir == "roughness" )  { des="Roughness"                ; max=100 ; min=-100 ;  at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="f" ;    }
if(dir == "tri" )      { des="Terrain roughness index"    ; max=100 ; min=-100 ;  at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="g" ;    }
if(dir == "tpi" )      { des="Topographic position index" ; max=100 ; min=-100 ;  at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="h" ;    }
if(dir == "vrm" )      { des="Vector ruggedness measure"  ; max=100 ; min=-100 ;  at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="i" ;    }
if(dir == "cti" )      { des="Compound topographic index" ; max=100 ; min=-100 ;  at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="j" ;    }
if(dir == "spi" )      { des="Stream power index"         ; max=100 ; min=-100 ;  at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="k" ;    }
if(dir == "aspectcosine" )    { des="Aspect cosine"       ; max=100 ; min=-100 ;  at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="l" ;    } 
if(dir == "aspectsine" )      { des="Aspect sine"         ; max=100 ; min=-100 ;  at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="m" ;    }
if(dir == "slope" )           { des="Slope"               ; max=100 ; min=-100 ;  at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="n" ;    }
if(dir == "eastness")         { des="Eastness"            ; max=100 ; min=-100 ;  at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="o" ;    }
if(dir == "northness" )       { des="Northness"           ; max=100 ; min=-100 ;  at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="p" ;     }
if(dir == "pcurv" )    { des="Profile curvature"          ; max=100 ; min=-100 ;  at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="q" ;    }
if(dir == "tcurv" )    { des="Tangential curvature"       ; max=100 ; min=-100 ;  at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="r" ;    } 
if(dir == "dx" )       { des="1st partial derivative (E-W slope)" ; max=100 ; min=-100 ; at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="s" ;    }
if(dir == "dy" )       { des="1st partial derivative (N-S slope)" ; max=100 ; min=-100 ; at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="t" ;    } 
if(dir == "dxx" )      { des="2nd partial derivative (E-W slope)" ; max=100 ; min=-100 ; at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="u" ;    }
if(dir == "dyy" )      { des="2nd partial derivative (N-S slope)" ; max=100 ; min=-100 ; at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="v" ;    }
if(dir == "dxy" )      { des="2nd partial derivative"             ; max=100 ; min=-100 ; at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="w" ;    }
if(dir == "convergence" ) { des="Convergence"                     ; max=100 ; min=-100 ; at=c( -100,-50,0,+50,+100) ; labels=c("<-100","-50","0","+50",">+100") ; letter="x" ;    }
print(dir)
print(max)
print(min)
}
if ( dir == "elev_cor" ) {
plot( elev_M, elev_N, pch = 16, cex = .1 , xaxt = "n" , yaxt = "n" , main="Elevation 3DEP vs MERIT", cex.main=0.65 , font.main=2 )
abline(0, 1 , col="red")
fit = lm ( elev_N@data@values ~ elev_M@data@values  ) 
abline(fit, col = "blue")
axis(side = 1, mgp=c(3,-0.35,0),        , cex.axis=0.56 , at =c(round(minM),round(maxM)), labels =c(round(minM),round(maxM))  , tck=0)  # x axis  
axis(side = 2, mgp=c(3,0.2,0)  ,  las=2 , cex.axis=0.56 , at =c(round(minN)-20, round(maxN)), labels =c(round(minN),round(maxN))  , tck=0)  # y axis 
text( 2940 , 2870  , "c" ,  font=2   ,   xpd=TRUE , cex=1 )
text( 1200 , 2420 , "3DEP (m)"    , font=2 ,  srt=90 ,  xpd=TRUE , cex=0.6 )
text( 2470 , 1220 , "MERIT (m)"   , font=2 ,  srt=0  ,  xpd=TRUE , cex=0.6 )
}
if (( dir != "elev_cor" ) &&  (  dir != "dxx"   )     ) { 
plot(raster  , col=cols , yaxt="n" , xaxt="n" , xlab="" , ylab="" , main=des  , legend=FALSE  , cex.main=0.65 , font.main=2 )
plot(raster, axis.args=list( at=at , labels=labels , line=-0.85, tck=0 , cex.axis=0.56 , lwd = 0  ) ,  smallplot=c(0.83,0.87, 0.1,0.8), zlim=c( min, max ) , legend.only=TRUE , legend.width=1, legend.shrink=0.75 , col=cols)
text(6912000 , 5219400 , letter ,  font=2   ,   xpd=TRUE , cex=1 )
}
if ( dir == "dxx"   ) { 
plot(raster  , col=cols ,  yaxp=c(5201000, 5217400 ,1) , xaxp=c(6891000, 6909000,1) , tck=-0.05, cex.axis=0.8 , main=des  , legend=FALSE  , cex.main=0.65 , font.main=2 )
plot(raster, axis.args=list( at=at , labels=labels , line=-0.85, tck=0  , cex.axis=0.56 ,  lwd = 0 ) ,  smallplot=c(0.83,0.87, 0.1,0.8), zlim=c( min, max ) , legend.only=TRUE , legend.width=1, legend.shrink=0.75 , col=cols)
text(6912000 , 5219400  , letter ,  font=2   ,   xpd=TRUE , cex=1 )
}
}
dev.off()
q()
EOF
