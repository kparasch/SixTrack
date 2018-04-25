! =================================================================================================
!  STANDARD OUTPUT MODULE
!  Last modified: 2018-03-22
!  For CR version, this is the "buffer file" fort.92;
!  Otherwise write directly to "*" aka iso_fortran_env::output_unit (usually unit 6)
! =================================================================================================
module crcoall
  
  implicit none
  
  integer lout
  save lout
  
end module crcoall

! ================================================================================================ !
!  SixTrack String Type
! ~~~~~~~~~~~~~~~~~~~~~~
!  V.K. Berglyd Olsen, BE-ABP-HSS
!  Last Modified: 2018-04-25
!
!  Usage
!    Declaration:   type(string) aString
!    Get:           aString%get()                   => Returns chracater array
!    Set:           aString%set("foo")              => Returns string
!    Assignment:    aString = "foo"                 => Returns string
!    Addition:      aString = aString + "bar"       => Returns combined string "foobar"
!    Concatenation: write(*,*) "This is "//aString  => On-the-fly conversion to character array
!    Comparison:    aString == "foobar"             => Compares a string/char to string/char
!    Comparison:    aString /= "barfoo"             => Compares a string/char to string/char
! ================================================================================================ !
module strings
  
  implicit none
  
  type, public :: string
    character(len=:), allocatable, public :: chr
  contains
    procedure, public,  pass(this)  :: get => getString
    procedure, public,  pass(this)  :: set => setString
    
    procedure, private, pass(left)  :: assignStrStr
    procedure, private, pass(left)  :: assignStrChr
    procedure, private, pass(right) :: assignChrStr
    
    procedure, private, pass(left)  :: appendStrStr
    procedure, private, pass(left)  :: appendStrChr
    
    procedure, private, pass(left)  :: concatStrStr
    procedure, private, pass(left)  :: concatStrChr
    procedure, private, pass(right) :: concatChrStr
    
    procedure, private, pass(left)  :: compStrStr
    procedure, private, pass(left)  :: compStrChr
    procedure, private, pass(right) :: compChrStr
    
    procedure, private, pass(left)  :: compNStrStr
    procedure, private, pass(left)  :: compNStrChr
    procedure, private, pass(right) :: compNChrStr
  end type string
  
  interface string
    module procedure stringConstructor
  end interface string
  
  interface assignment(=)
    module procedure assignStrStr
    module procedure assignStrChr
    module procedure assignChrStr
  end interface
  
  interface operator(+)
    module procedure appendStrStr
    module procedure appendStrChr
  end interface
  
  interface operator(//)
    module procedure concatStrStr
    module procedure concatStrChr
    module procedure concatChrStr
  end interface
  
  interface operator(==)
    module procedure compStrStr
    module procedure compStrChr
    module procedure compChrStr
  end interface
  
  interface operator(/=)
    module procedure compNStrStr
    module procedure compNStrChr
    module procedure compNChrStr
  end interface
  
contains
  
  type(string) function stringConstructor()
    stringConstructor%chr = ""
  end function stringConstructor
  
  pure function getString(this) result(retValue)
    class(string),    intent(in)  :: this
    character(len=:), allocatable :: retValue
    retValue = this%chr
  end function getString
  
  pure subroutine setString(this, setValue)
    class(string),    intent(inout) :: this
    character(len=*), intent(in)    :: setValue
    this%chr = setValue
  end subroutine setString
  
  ! ================================================================ !
  !  String Assignment
  ! ================================================================ !
  subroutine assignStrStr(left, right)
    class(string), intent(inout) :: left
    class(string), intent(in)    :: right
    left%chr = right%chr
  end subroutine assignStrStr
  
  elemental subroutine assignStrChr(left, right)
    class(string),    intent(inout) :: left
    character(len=*), intent(in)    :: right
    left%chr = right
  end subroutine assignStrChr
  
  elemental subroutine assignChrStr(left, right)
    character(len=*), intent(inout) :: left
    class(string),    intent(in)    :: right
    left = right%chr
  end subroutine assignChrStr
  
  ! ================================================================ !
  !  Append Strings with +, Returning String
  ! ================================================================ !
  type(string) elemental function appendStrStr(left, right)
    class(string),    intent(in)  :: left
    class(string),    intent(in)  :: right
    character(len=:), allocatable :: tmpChr
    integer nOld, nNew
    nOld =        len(left%chr)
    nNew = nOld + len(right%chr)
    allocate(character(nNew) :: tmpChr)
    tmpChr(1:nOld)      = left%chr
    tmpChr(nOld+1:nNew) = right%chr
    appendStrStr%chr    = tmpChr
    deallocate(tmpChr)
  end function appendStrStr
  
  type(string) elemental function appendStrChr(left, right)
    class(string),    intent(in)  :: left
    character(len=*), intent(in)  :: right
    character(len=:), allocatable :: tmpChr
    integer nOld, nNew
    nOld =        len(left%chr)
    nNew = nOld + len(right)
    allocate(character(nNew) :: tmpChr)
    tmpChr(1:nOld)      = left%chr
    tmpChr(nOld+1:nNew) = right
    appendStrChr%chr    = tmpChr
    deallocate(tmpChr)
  end function appendStrChr
  
  ! ================================================================ !
  !  Concat Strings with //, Returning Character
  ! ================================================================ !
  elemental function concatStrStr(left, right) result(retValue)
    class(string),    intent(in)  :: left
    class(string),    intent(in)  :: right
    character(len=:), allocatable :: retValue
    integer nOld, nNew
    nOld =        len(left%chr)
    nNew = nOld + len(right%chr)
    allocate(character(nNew) :: retValue)
    retValue(1:nOld)      = left%chr
    retValue(nOld+1:nNew) = right%chr
  end function concatStrStr
  
  elemental function concatChrStr(left, right) result(retValue)
    character(len=*), intent(in)  :: left
    class(string),    intent(in)  :: right
    character(len=:), allocatable :: retValue
    integer nOld, nNew
    nOld =        len(left)
    nNew = nOld + len(right%chr)
    allocate(character(nNew) :: retValue)
    retValue(1:nOld)      = left
    retValue(nOld+1:nNew) = right%chr
  end function concatChrStr
  
  elemental function concatStrChr(left, right) result(retValue)
    class(string),    intent(in)  :: left
    character(len=*), intent(in)  :: right
    character(len=:), allocatable :: retValue
    integer nOld, nNew
    nOld =        len(left%chr)
    nNew = nOld + len(right)
    allocate(character(nNew) :: retValue)
    retValue(1:nOld)      = left%chr
    retValue(nOld+1:nNew) = right
  end function concatStrChr
  
  ! ================================================================ !
  !  Compare Strings, Equal
  ! ================================================================ !
  elemental function compStrStr(left, right) result(retValue)
    class(string), intent(in) :: left
    class(string), intent(in) :: right
    logical retValue
    retValue = left%chr == right%chr
  end function compStrStr
  
  elemental function compStrChr(left, right) result(retValue)
    class(string),    intent(in) :: left
    character(len=*), intent(in) :: right
    logical retValue
    retValue = left%chr == right
  end function compStrChr
  
  elemental function compChrStr(left, right) result(retValue)
    character(len=*), intent(in) :: left
    class(string),    intent(in) :: right
    logical retValue
    retValue = left == right%chr
  end function compChrStr
  
  ! ================================================================ !
  !  Compare Strings, Not Equal
  ! ================================================================ !
  elemental function compNStrStr(left, right) result(retValue)
    class(string), intent(in) :: left
    class(string), intent(in) :: right
    logical retValue
    retValue = left%chr /= right%chr
  end function compNStrStr
  
  elemental function compNStrChr(left, right) result(retValue)
    class(string),    intent(in) :: left
    character(len=*), intent(in) :: right
    logical retValue
    retValue = left%chr /= right
  end function compNStrChr
  
  elemental function compNChrStr(left, right) result(retValue)
    character(len=*), intent(in) :: left
    class(string),    intent(in) :: right
    logical retValue
    retValue = left /= right%chr
  end function compNChrStr
  
end module strings
