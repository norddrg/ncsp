Procedure editoi
 edit
 wait window 'Muutetaanko p‰iv‰m‰‰r‰? K/E'
 if lastkey()=107 or lastkey()=75
   replace chadate with date()
 endif
 select (lc_alias)
 on key label ctrl+b do isonay
 do ..\eesti\naytto
return