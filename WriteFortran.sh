#/bin/bash

if [ "$1" == "" ]; then
  echo "No Argument"
  if [ ! -e ./"1.f90" ]; then
    echo "Writing 1.f90"
    file="1.f90"
  else
    echo "1.f90 exist. Write other name"
    exit
  fi
else
  file="$1"
fi


touch $file
cat << EOS > $file
program main
implicit none
real(8), parameter :: pi = atan(1.0d0)*4.0d0
integer :: Nline, Nhead
character(:), allocatable :: Ifile

print *, "START reading parameters"
call set_input_file(Ifile,'input.dat')
call count_line_head(Ifile, Nline, Nhead)


print *, "Nline is ", Nline
print *, "Nhead is ", Nhead



stop "Normal termination"
contains

  subroutine count_line_head(Ifile, Nline, Nhead)
    character(*), intent(in) :: Ifile
    integer, intent(out) :: Nline, Nhead
!    integer, parameter :: Uinp = 20
    character(len=128) :: line
    integer :: Uinp

    open(newunit=Uinp,file=Ifile,status='old',err=900)

    ! +++ Count the number of line +++
      Nline = 0
      do
        read(Uinp,'()', end=100)
        Nline = Nline + 1
      end do
    100 continue
    ! +++ End Count the number of line +++

    ! +++ Checking header +++
      rewind(Uinp)
      Nhead = 0
      do
        read(Uinp,'(a)',end=901) line
        if (index(line,"#") == 0) exit
        Nhead = Nhead + 1
      end do
    ! +++ End Checking header +++
    close(Uinp)
    return
    900 stop  'ERROR!! There is no input file'
    901 stop  'ERROR!! Reading reach the end'
  end subroutine count_line_head

  subroutine set_input_file(Ifile,Def_file)
    integer :: leng
    character(:), allocatable, intent(out):: Ifile
    character(*), optional :: Def_file
    if ( command_argument_count() == 0) then
      Ifile = Def_file
      print *, "Reading from default file as ", Ifile
!      print *, 'ERROR!! There is no input file'
    else
      call get_command_argument(1, length=leng)
        allocate(character(leng) :: Ifile)
        call get_command_argument(1, Ifile)
      print *, "Reading from ", Ifile
    end if
    return
  end subroutine set_input_file

  subroutine random_seed_clock()
    integer :: nseed, clock
    integer, allocatable :: seed(:)

    call system_clock(clock)

    call random_seed(size=nseed)
    allocate(seed(nseed))
    seed = clock
    call random_seed(put=seed)
  end subroutine random_seed_clock

end program main

EOS

