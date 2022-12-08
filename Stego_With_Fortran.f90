program steganography
  use iso_c_binding, only: c_int, c_size_t, c_char, c_char_ptr
  use iso_fortran_env, only: output_unit
  use, intrinsic :: iso_fortran_env, only: int32, int64

  ! Declare variables to hold the input image and the data to be injected
  type(c_ptr) :: image, data
  integer(c_size_t) :: imageSize, dataSize

  ! Read the input image into memory
  call c_f_pointer(image, read_file("in.png"))
  imageSize = size(image)

  ! Read the data to be injected into memory
  call c_f_pointer(data, read_file("data.txt"))
  dataSize = size(data)

  ! Encode the data size as a 4-byte big-endian integer
  integer(c_int) :: dataSizeBE
  dataSizeBE = dataSize
  call swap_endian(dataSizeBE)

  ! Inject the data size and the data into the input image
  call inject_data(image, imageSize, dataSizeBE, 4)
  call inject_data(image, imageSize, data, dataSize)

  ! Write the modified image to a file
  call write_file("out.png", image, imageSize)

contains

  ! Define a subroutine to read a file into memory
  function read_file(filename) result(ptr)
    ! Arguments
    character(len=*), intent(in) :: filename

    ! Result
    type(c_ptr) :: ptr

    ! Local variables
    integer :: fd
    integer(c_size_t) :: size

    ! Open the file
    fd = open(filename, O_RDONLY)
    if (fd < 0) stop "Error opening file"

    ! Get the size of the file
    size = lseek(fd, 0, SEEK_END)

    ! Allocate memory to hold the contents of the file
    call c_f_pointer(ptr, malloc(size))

    ! Rewind the file to the beginning
    lseek(fd, 0, SEEK_SET)

    ! Read the contents of the file into memory
    read(fd, ptr, size)

    ! Close the file
    close(fd)
  end function read_file

  ! Define a subroutine to write data to a file
  subroutine write_file(filename, data, size)
    ! Arguments
    character(len=*), intent(in) :: filename
    type(c_ptr), intent(in) :: data
    integer(c_size_t), intent(in) :: size

    ! Local variables
    integer :: fd

    ! Open the file
    fd = open(filename, O_WRONLY | O_CREAT)
    if (fd < 0) stop "Error opening file"

    ! Write the data to the file
    write(fd, data, size)

    ! Close the file
    close(
