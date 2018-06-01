! =================================================================================================
!  Mathlib Bouncer
!  Last modified: 2018-04-27
! =================================================================================================
module mathlib_bouncer

  use floatPrecision
  implicit none

  !These are the actual "bouncy functions" users are supposed to call
  public :: sin_mb, asin_mb, sinh_mb, cos_mb, acos_mb, cosh_mb, tan_mb, atan_mb, atan2_mb, exp_mb, log_mb, log10_mb

  !For linking with CRLIBM
#ifdef CRLIBM
  private :: acos_rn, asin_rn, atan2_rn
  
  !Can't declare them private as they have BIND labels,
  ! however they should not be called from outside this module.
  !private :: exp_rn, log_rn, log10_rn, atan_rn, tan_rn, sin_rn, cos_rn, sinh_rn, cosh_rn
  
  !! Interface definitions for the other functions in crlibm
  interface
     
     real(kind=c_double) function exp_rn(arg) bind(C,name="exp_rn")
       use, intrinsic :: iso_c_binding, only : c_double
       implicit none
       real(kind=c_double), intent(in), VALUE :: arg
     end function exp_rn

     real(kind=c_double) function log_rn(arg) bind(C,name="log_rn")
       use, intrinsic :: iso_c_binding, only : c_double
       implicit none
       real(kind=c_double), intent(in), VALUE :: arg
     end function log_rn

     real(kind=c_double) function log10_rn(arg) bind(C,name="log10_rn")
       use, intrinsic :: iso_c_binding, only : c_double
       implicit none
       real(kind=c_double), intent(in), VALUE :: arg
     end function log10_rn

     real(kind=c_double) function atan_rn(arg) bind(C,name="atan_rn")
       use, intrinsic :: iso_c_binding, only : c_double
       implicit none
       real(kind=c_double), intent(in), VALUE :: arg
     end function atan_rn
     
     real(kind=c_double) function tan_rn(arg) bind(C,name="tan_rn")
       use, intrinsic :: iso_c_binding, only : c_double
       implicit none
       real(kind=c_double), intent(in), VALUE :: arg
     end function tan_rn

     real(kind=c_double) function sin_rn(arg) bind(C,name="sin_rn")
       use, intrinsic :: iso_c_binding, only : c_double
       implicit none
       real(kind=c_double), intent(in), VALUE :: arg
     end function sin_rn

     real(kind=c_double) function cos_rn(arg) bind(C,name="cos_rn")
       use, intrinsic :: iso_c_binding, only : c_double
       implicit none
       real(kind=c_double), intent(in), VALUE :: arg
     end function cos_rn

     real(kind=c_double) function sinh_rn(arg) bind(C,name="sinh_rn")
       use, intrinsic :: iso_c_binding, only : c_double
       implicit none
       real(kind=c_double), intent(in), VALUE :: arg
     end function sinh_rn

     real(kind=c_double) function cosh_rn(arg) bind(C,name="cosh_rn")
       use, intrinsic :: iso_c_binding, only : c_double
       implicit none
       real(kind=c_double), intent(in), VALUE :: arg
     end function cosh_rn
     
  end interface
#endif

contains

  !Definition of the MathlibBouncer (_mb) functions
  real(kind=fPrec) function sin_mb(arg)
    implicit none
    real(kind=fPrec) arg
    intent(in) arg
    
#ifndef CRLIBM
    !Input KIND = output KIND
    sin_mb=sin(arg)
#else
    sin_mb=sin_rn(arg)
#endif
  end function sin_mb

  real(kind=fPrec) function asin_mb(arg)
    implicit none
    real(kind=fPrec) arg
    intent(in) arg
    
#ifndef CRLIBM
    !Input KIND = output KIND
    asin_mb=asin(arg)
#else
    asin_mb=asin_rn(arg)
#endif
  end function asin_mb

  real(kind=fPrec) function sinh_mb(arg)
    implicit none
    real(kind=fPrec) arg
    intent(in) arg
    
#ifndef CRLIBM
    !Input KIND = output KIND
    sinh_mb=sinh(arg)
#else
    sinh_mb=sinh_rn(arg)
#endif
  end function sinh_mb
  
  real(kind=fPrec) function cos_mb(arg)
    implicit none
    real(kind=fPrec) arg
    intent(in) arg
    
#ifndef CRLIBM
    !Input KIND = output KIND
    cos_mb=cos(arg)
#else
    cos_mb=cos_rn(arg)
#endif
  end function cos_mb
  
  real(kind=fPrec) function acos_mb(arg)
    implicit none
    real(kind=fPrec) arg
    intent(in) arg
    
#ifndef CRLIBM
    !Input KIND = output KIND
    acos_mb=acos(arg)
#else
    acos_mb=acos_rn(arg)
#endif
  end function acos_mb
  
  real(kind=fPrec) function cosh_mb(arg)
    implicit none
    real(kind=fPrec) arg
    intent(in) arg
    
#ifndef CRLIBM
    !Input KIND = output KIND
    cosh_mb=cosh(arg)
#else
    cosh_mb=cosh_rn(arg)
#endif
  end function cosh_mb
  
  real(kind=fPrec) function tan_mb(arg)
    implicit none
    real(kind=fPrec) arg
    intent(in) arg
    
#ifndef CRLIBM
    !Input KIND = output KIND
    tan_mb=tan(arg)
#else
    tan_mb=tan_rn(arg)
#endif
  end function tan_mb
  
  real(kind=fPrec) function atan_mb(arg)
    implicit none
    real(kind=fPrec) arg
    intent(in) arg
    
#ifndef CRLIBM
    !Input KIND = output KIND
    atan_mb=atan(arg)
#else
    atan_mb=atan_rn(arg)
#endif
  end function atan_mb
  
  real(kind=fPrec) function atan2_mb(y,x)
    implicit none
    real(kind=fPrec) y,x
    intent(in) y,x
    
#ifndef CRLIBM
    !Input KIND = output KIND
    atan2_mb=atan2(y,x)
#else
    atan2_mb=atan2_rn(y,x)
#endif
  end function atan2_mb

  real(kind=fPrec) function exp_mb(arg)
    implicit none
    real(kind=fPrec) arg
    intent(in) arg
    
#ifndef CRLIBM
    !Input KIND = output KIND
    exp_mb=exp(arg)
#else
    exp_mb=exp_rn(arg)
#endif
  end function exp_mb

  real(kind=fPrec) function log_mb(arg)
    implicit none
    real(kind=fPrec) arg
    intent(in) arg
    
#ifndef CRLIBM
    !Input KIND = output KIND
    log_mb=log(arg)
#else
    log_mb=log_rn(arg)
#endif
  end function log_mb

  real(kind=fPrec) function log10_mb(arg)
    implicit none
    real(kind=fPrec) arg
    intent(in) arg
    
#ifndef CRLIBM
    !Input KIND = output KIND
    log10_mb=log10(arg)
#else
    log10_mb=log10_rn(arg)
#endif
  end function log10_mb
  
#ifdef CRLIBM
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Functions moved from sixtrack.s, wrapping parts of crlibm !
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  real(kind=real64) function acos_rn(x)
    use, intrinsic :: iso_fortran_env, only : real64
    implicit none
    real(kind=real64) x,pi,pi2
    logical myisnan
    data pi  /3.1415926535897932d0/
    data pi2 /1.5707963267948966d0/
    if (myisnan(x,x)) then
       acos_rn=x
    elseif (abs(x).eq.0.0d0) then
       acos_rn=pi2
    else
       !       acos_rn=atan_rn(sqrt(1.0d0-x*x)/x)
       ! Try using (1-x)*(1+x) in case x is very small.........
       ! or close to 1.....write a test program!!!
       acos_rn=atan_rn(sqrt((1.0d0-x)*(1.0d0+x))/x)
       if (x.lt.0d0) then
          acos_rn=pi+acos_rn
       endif
    endif
  end function acos_rn

  real(kind=real64) function asin_rn(x)
    use, intrinsic :: iso_fortran_env, only : real64
    implicit none
    real(kind=real64) x,pi2
    logical myisnan
    data pi2 /1.5707963267948966d0/
    if (myisnan(x,x)) then
       asin_rn=x
       return
    endif
    if (abs(x).eq.1.0d0) then
       asin_rn=sign(pi2,x)
    else
       !       asin_rn=atan_rn(x/sqrt(1.0d0-x*x))
       ! Try using (1-x)*(1+x) in case x is very small.........
       ! or close to 1.....write a test program!!!
       asin_rn=atan_rn(x/sqrt((1.0d0-x)*(1.0d0+x)))
    endif
  end function asin_rn

  real(kind=real64) function atan2_rn(y,x)
    use, intrinsic :: iso_fortran_env, only : real64
    implicit none
    real(kind=real64) x,y,pi,pi2
    logical myisnan
    data pi  /3.1415926535897932d0/
    data pi2 /1.5707963267948966d0/
    if (x.eq.0d0) then
       if (y.eq.0d0) then
          ! Should get me a NaN
          atan2_rn=atan_rn(y/x)
       else
          atan2_rn=sign(pi2,y)
       endif
    else
       if (y.eq.0d0) then
          if (x.gt.0d0) then
             atan2_rn=0d0
          else
             atan2_rn=pi
          endif
       else
          atan2_rn=atan_rn(y/x)
          if (x.lt.0d0) then
             atan2_rn=sign(pi,y)+atan2_rn
          endif
       endif
    endif
  end function atan2_rn
#endif

end module mathlib_bouncer