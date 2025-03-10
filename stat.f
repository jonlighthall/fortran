      PROGRAM test_stat
      INTEGER, DIMENSION(13) :: buff
      INTEGER :: status
      CALL STAT("/etc/passwd", buff, status)
      IF (status == 0) THEN
         WRITE (*, FMT="('Device ID:', T30, I19)") buff(1)
         WRITE (*, FMT="('Inode number:', T30, I19)") buff(2)
         WRITE (*, FMT="('File mode (octal):', T30, O19)") buff(3)
         WRITE (*, FMT="('Number of links:', T30, I19)") buff(4)
         WRITE (*, FMT="('Owner''s uid:', T30, I19)") buff(5)
         WRITE (*, FMT="('Owner''s gid:', T30, I19)") buff(6)
         WRITE (*, FMT="('Device where located:', T30, I19)") buff(7)
         WRITE (*, FMT="('File size:', T30, I19)") buff(8)
         WRITE (*, FMT="('Last access time:', T30, A19)") CTIME(buff(9))
         WRITE (*, FMT="('Last modification time', T30, A19)") CTIME(buff(10))
         WRITE (*, FMT="('Last status change time:', T30, A19)") CTIME(buff(11))
         WRITE (*, FMT="('Preferred block size:', T30, I19)") buff(12)
         WRITE (*, FMT="('No. of blocks allocated:', T30, I19)") buff(13)
      END IF
      END PROGRAM
