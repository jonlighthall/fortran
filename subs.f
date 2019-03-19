      PROGRAM subs
      DO i = 2, 4
         CALL f(i)              !! Create array of size i
         CALL f2(i,i)           !! Create array of size ixi
      END DO
      END
