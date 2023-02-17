program calculate_pi
    implicit none
    integer :: n, i, count
    real :: x, y, pi_estimate

    ! Set the number of random points to generate
    n = 1000000

    ! Initialize the count of points inside the circle to zero
    count = 0

    ! Generate n random points and count the number that fall inside the circle
    do i = 1, n
        x = random_number()
        y = random_number()
        if (x**2 + y**2 <= 1.0) then
            count = count + 1
        end if
    end do

    ! Estimate the value of pi based on the count of points inside the circle
    pi_estimate = 4.0 * count / n

    ! Output the estimated value of pi
    write(*,*) 'Estimated value of pi = ', pi_estimate

end program calculate_pi
