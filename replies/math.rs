! sub zero	= 0
! sub one	= 1
! sub two	= 2
! sub three	= 3
! sub four	= 4
! sub five	= 5
! sub six	= 6
! sub seven	= 7
! sub eight	= 8
! sub nine	= 9
! sub ten	= 10
! sub eleven	= 11
! sub twelve	= 12
! sub thirteen	= 13
! sub fourteen	= 14
! sub fifteen	= 15
! sub sixteen	= 16
! sub seventeen	= 17
! sub eighteen	= 18
! sub ninteen	= 19
! sub twenty	= 20

+ (what is|multiply) # (times|by|and|multipled by) #
- <set acc=<star2>><mult acc=<star4>><get acc>

+ (what is|add) # (plus|to|and|added to) #
- <set acc=<star2>><add acc=<star4>><get acc>

+ (what is|subtract) # (minus|from|subtracted from) #
- <set acc=<star2>><sub acc=<star4>><get acc>

+ (what is|divide) # (divided by|by) #
- <set acc=<star2>><div acc=<star4>><get acc>

+ (divide|how many times does) # [go] into #
- <set acc=<star3>><div acc=<star2>><get acc>

+ what is # (and|by|to|from) #
- If you want me to do arithmetic, please be more specific.

+ what is # * #
- I am unfamiliar with the mathematical operation "<star2>".
