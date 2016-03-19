magimage<-function(x, y, z, zlim, xlim, ylim, col = grey((0:1e3)/1e3), add = FALSE, useRaster=TRUE, asp=1, lo=0, hi=1, flip=FALSE, range=c(0,1), type = "quan", stretch="lin", stretchscale=1, bad=NA, clip="", axes=TRUE, frame.plot=TRUE, ...) {
  if(is.list(x)){
    if('y' %in% names(x)){y=x$y}
    if('z' %in% names(x)){z=x$z}
    if('x' %in% names(x)){x=x$x}
  }else{
    if(!missing(z)){
      if(is.matrix(z)){
        if(missing(x)){y=seq(0,dim(z)[1])}
        if(missing(y)){y=seq(0,dim(z)[2])}
      }
    }
    if(!missing(x)){
      if(is.matrix(x)){
        z=x
        x=seq(0,dim(z)[1])
        if(missing(y)){y=seq(0,dim(z)[2])}
      }
    }
  }
  if(missing(xlim)){xlim=range(x)}
  if(missing(ylim)){ylim=range(y)}
  if(missing(zlim)){zlim=range}
  if(x[1]>x[length(x)]){x=rev(x); xlim=rev(xlim)}
  if(y[1]>y[length(y)]){y=rev(y); ylim=rev(ylim)}
  if(length(x)==dim(z)[1]){
    oldrange=diff(xlim)
    xlim[1]=xlim[1]-oldrange/dim(z)[1]
    xlim[2]=xlim[2]+oldrange/dim(z)[1]
  }
  if(length(y)==dim(z)[2]){
    oldrange=diff(ylim)
    ylim[1]=ylim[1]-oldrange/dim(z)[2]
    ylim[2]=ylim[2]+oldrange/dim(z)[2]
  }
  z=magmap(data=z, lo=lo, hi=hi, flip=flip, range=range, type=type, stretch=stretch, stretchscale=stretchscale, bad=bad, clip=clip)$map
  image(x=x, y=y, z=z, zlim=zlim, xlim=xlim, ylim=ylim, col=col, add=add, useRaster=useRaster, axes=FALSE, asp=asp, xlab='', ylab='', main='')
  if(add==FALSE){
    if(axes){
      magaxis(...)
      if(frame.plot){box()}
    }
  }
}