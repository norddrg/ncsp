procedure siiryhd
*This creates combined file for NCSP+
  set talk off
  set console off
  select ncsp_koo
  set order to ncsp
  select 0
  use extstr.dbf
  set safety off
  on error return
  copy to apu
  on error
  select 0
  use ..\suomi\ncsp_luv alias ots_sec
  wait window nowait 'The file is beeing transferred to ../ncsp/ncsp_plus.dbf file'
  set safety on
  lc_luv='   '
  lc_ryh='   '
  lc_ala='   '
  lc_ala2='   '
  select ncsp_luv
  set filter to not released
  select ncsp_ryh
  set filter to not released
  select ncsp_ala
  set filter to not released
  select ncsp_koo
  set order to code
  set filter to 
  goto top
  lc_siirn=0
  do while not eof()
    lc_siirn=lc_siirn+1
    if lc_siirn=100*int(lc_siirn/100)
      wait window nowait ncsp_koo.ncsp
    endif
    if ncsp_koo.code<>lc_luv
      select ncsp_luv
      seek substr(ncsp_koo.ncsp,1,1)
      if found()
        insert into apu (ord, ncsp, text, usedate, chadate,;
        headline, short);
        values (ncsp_luv.ncsp, ncsp_luv.ncsp, ncsp_luv.text, ncsp_luv.usedate, ncsp_luv.chadate,;
        .t., ncsp_luv.short)
        lc_luv=substr(ncsp_luv.ncsp,1,1)
        * Danish checkup
        select ncsp_sec
        use ..\tanska\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,1)
        if found()
          replace apu.code_den with substr(ncsp_koo.ncsp,1,1)
        endif
        * English checkup
        select ncsp_sec
        use ..\englanti\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,1)
        if found()
          replace apu.code_eng with substr(ncsp_koo.ncsp,1,1)
        endif
        * Estonian checkup
        select ncsp_sec
        use ..\eesti\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,1)
        if found()
          replace apu.code_est with substr(ncsp_koo.ncsp,1,1)
        endif
        * Latvian checkup
        select ncsp_sec
        use ..\latvia\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,1)
        if found()
          replace apu.code_lat with substr(ncsp_koo.ncsp,1,1)
        endif
        * Icelandic checkup
        select ncsp_sec
        use ..\islanti\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,1)
        if found()
          replace apu.code_ice with substr(ncsp_koo.ncsp,1,1)
        endif
        * Finish checkup
        select ncsp_sec
        use ..\suomi\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,1)
        if found()
          replace apu.code_fin with substr(ncsp_koo.ncsp,1,1)
          select ots_sec
          use ..\suomi\ncsp_luv alias ots_sec
          set order to ncsp
          seek substr(ncsp_koo.ncsp,1,1)
          if found()
            replace apu.finish with ots_sec.text
            replace apu.fin_swe with ots_sec.text_2
            replace apu.use_fin with ots_sec.usedate
            replace apu.cha_fin with ots_sec.chadate
            replace apu.rel_fin with ots_sec.reldate
          endif
        endif
        * Norwegian checkup
        select ncsp_sec
        use ..\norja\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,1)
        if found()
          replace apu.code_nor with substr(ncsp_koo.ncsp,1,1)
        endif
        * Swedish checkup
        select ncsp_sec
        use ..\ruotsi\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,1)
        if found()
          replace apu.code_swe with substr(ncsp_koo.ncsp,1,1)
        endif
      endif
    endif
    if ncsp_koo.code<>lc_ryh
      select ncsp_ryh
      seek substr(ncsp_koo.ncsp,1,2)
      if found()
        insert into apu (ord, ncsp, text, usedate, chadate,;
        headline, short);
        values (ncsp_ryh.ncsp, ncsp_ryh.ncsp, ncsp_ryh.text, ncsp_ryh.usedate, ncsp_ryh.chadate,;
        .t., ncsp_ryh.short)
        lc_ryh=substr(ncsp_ryh.ncsp,1,2)
        * Danish checkup
        select ncsp_sec
        use ..\tanska\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,2)
        if found()
          replace apu.code_den with substr(ncsp_koo.ncsp,1,2)
        endif
        * English checkup
        select ncsp_sec
        use ..\englanti\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,2)
        if found()
          replace apu.code_eng with substr(ncsp_koo.ncsp,1,2)
        endif
        * Estonian checkup
        select ncsp_sec
        use ..\eesti\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,2)
        if found()
          replace apu.code_est with substr(ncsp_koo.ncsp,1,2)
        endif
        * Icelandic checkup
        select ncsp_sec
        use ..\islanti\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,2)
        if found()
          replace apu.code_ice with substr(ncsp_koo.ncsp,1,2)
        endif
        * Latvian checkup
        select ncsp_sec
        use ..\latvia\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,2)
        if found()
          replace apu.code_lat with substr(ncsp_koo.ncsp,1,2)
        endif
        * Finish checkup
        select ncsp_sec
        use ..\suomi\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,2)
        if found()
          replace apu.code_fin with substr(ncsp_koo.ncsp,1,2)
          select ots_sec
          use ..\suomi\ncsp_ryh alias ots_sec
          set order to ncsp
          seek substr(ncsp_koo.ncsp,1,2)
          if found()
            replace apu.finish with ots_sec.text
            replace apu.fin_swe with ots_sec.text_2
            replace apu.use_fin with ots_sec.usedate
            replace apu.cha_fin with ots_sec.chadate
            replace apu.rel_fin with ots_sec.reldate
          endif
        endif
        * Norwegian checkup
        select ncsp_sec
        use ..\norja\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,2)
        if found()
          replace apu.code_nor with substr(ncsp_koo.ncsp,1,2)
        endif
        * Swedish checkup
        select ncsp_sec
        use ..\ruotsi\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,2)
        if found()
          replace apu.code_swe with substr(ncsp_koo.ncsp,1,2)
        endif
      endif
    endif
    if ncsp_koo.code<>lc_ala
      select ncsp_ala
      seek substr(ncsp_koo.ncsp,1,3)+' '
      if found()
        insert into apu (ord, ncsp, text, usedate, chadate,;
        headline, short);
        values (ncsp_ala.ncsp, ncsp_ala.ncsp, ncsp_ala.text, ncsp_ala.usedate, ncsp_ala.chadate,;
        .t., ncsp_ala.short)
        lc_ala=substr(ncsp_ala.ncsp,1,3)
        * Danish checkup
        select ncsp_sec
        use ..\tanska\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,3)
        if found()
          replace apu.code_den with substr(ncsp_koo.ncsp,1,3)
        endif
        * English checkup
        select ncsp_sec
        use ..\englanti\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,3)
        if found()
          replace apu.code_eng with substr(ncsp_koo.ncsp,1,3)
        endif
        * Estonian checkup
        select ncsp_sec
        use ..\eesti\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,3)
        if found()
          replace apu.code_est with substr(ncsp_koo.ncsp,1,3)
        endif
        * Icelandic checkup
        select ncsp_sec
        use ..\islanti\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,3)
        if found()
          replace apu.code_ice with substr(ncsp_koo.ncsp,1,3)
        endif
        * Latvian checkup
        select ncsp_sec
        use ..\latvia\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,3)
        if found()
          replace apu.code_lat with substr(ncsp_koo.ncsp,1,3)
        endif
        * Finish checkup
        select ncsp_sec
        use ..\suomi\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,3)
        if found()
          replace apu.code_fin with substr(ncsp_koo.ncsp,1,3)
          select ots_sec
          use ..\suomi\ncsp_ala alias ots_sec
          set order to ncsp
          seek substr(ncsp_koo.ncsp,1,3)
          if found()
            replace apu.finish with ots_sec.text
            replace apu.fin_swe with ots_sec.text_2
            replace apu.use_fin with ots_sec.usedate
            replace apu.cha_fin with ots_sec.chadate
            replace apu.rel_fin with ots_sec.reldate
          endif
        endif
        * Norwegian checkup
        select ncsp_sec
        use ..\norja\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,3)
        if found()
          replace apu.code_den with substr(ncsp_koo.ncsp,1,3)
        endif
        * Swedish checkup
        select ncsp_sec
        use ..\ruotsi\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,3)
        if found()
          replace apu.code_swe with substr(ncsp_koo.ncsp,1,3)
        endif
      endif
    endif
    if ncsp_koo.code<>lc_ala2
      select ncsp_ala
      seek substr(ncsp_koo.ncsp,1,4)
      if found()
        insert into apu (ord, ncsp, text, usedate, chadate,;
        headline, short);
        values (ncsp_ala.ncsp, ncsp_ala.ncsp, ncsp_ala.text, ncsp_ala.usedate, ncsp_ala.chadate,;
        .t., ncsp_ala.short)
        lc_ala2=substr(ncsp_ala.ncsp,1,4)
        * Danish checkup
        select ncsp_sec
        use ..\tanska\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,4)
        if found()
          replace apu.code_den with substr(ncsp_koo.ncsp,1,4)
        endif
        * English checkup
        select ncsp_sec
        use ..\englanti\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,4)
        if found()
          replace apu.code_eng with substr(ncsp_koo.ncsp,1,4)
        endif
        * Estonian checkup
        select ncsp_sec
        use ..\eesti\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,4)
        if found()
          replace apu.code_est with substr(ncsp_koo.ncsp,1,4)
        endif
        * Icelandic checkup
        select ncsp_sec
        use ..\islanti\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,4)
        if found()
          replace apu.code_ice with substr(ncsp_koo.ncsp,1,4)
        endif
        * Latvian checkup
        select ncsp_sec
        use ..\latvia\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,4)
        if found()
          replace apu.code_lat with substr(ncsp_koo.ncsp,1,4)
        endif
        * Finish checkup
        select ncsp_sec
        use ..\suomi\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,4)
        if found()
          replace apu.code_fin with substr(ncsp_koo.ncsp,1,4)
          select ots_sec
          use ..\suomi\ncsp_ala alias ots_sec
          set order to ncsp
          seek substr(ncsp_koo.ncsp,1,4)
          if found()
            replace apu.finish with ots_sec.text
            replace apu.fin_swe with ots_sec.text_2
            replace apu.use_fin with ots_sec.usedate
            replace apu.cha_fin with ots_sec.chadate
            replace apu.rel_fin with ots_sec.reldate
          endif
        endif
        * Norwegian checkup
        select ncsp_sec
        use ..\norja\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,4)
        if found()
          replace apu.code_den with substr(ncsp_koo.ncsp,1,4)
        endif
        * Swedish checkup
        select ncsp_sec
        use ..\ruotsi\ncsp_koo alias ncsp_sec
        set order to ncsp
        seek substr(ncsp_koo.ncsp,1,4)
        if found()
          replace apu.code_swe with substr(ncsp_koo.ncsp,1,4)
        endif
      endif
    endif
    insert into apu (ord, ncsp, text, usedate, chadate,;
    reldate, released, subst, code_den, code_eng, code_est, code_fin, code_ice, code_nor, code_swe, code_lat, mapp, headline, nc, short);
    values (ncsp_koo.code, ncsp_koo.ncsp, ncsp_koo.text, ncsp_koo.usedate, ncsp_koo.chadate,;
    ncsp_koo.reldate, ncsp_koo.released, ncsp_koo.subst, ncsp_koo.code_den, ncsp_koo.code_eng, ncsp_koo.code_est, ncsp_koo.code_fin,;
    ncsp_koo.code_ice, ncsp_koo.code_nor, ncsp_koo.code_swe, ncsp_koo.code_lat, ' ', .f., ncsp_koo.nc, ncsp_koo.short)
    if ncsp_koo.code_fin<>' '
      p_kieli='Fin'
      select ncsp_sec
      use ..\suomi\ncsp_koo alias ncsp_sec
      set order to code
      select ncsp_koo
      set relation to trim(code_fin) into ncsp_sec
      replace apu.finish with ncsp_sec.text
      replace apu.fin_swe with ncsp_sec.text_2
      replace apu.mapp_fin with ncsp_sec.ncsp
      replace apu.use_fin with ncsp_sec.usedate
      replace apu.cha_fin with ncsp_sec.chadate
      replace apu.rel_fin with ncsp_sec.reldate
    endif
    if ncsp_koo.code_swe<>' '
      p_kieli='Swe'
      select ncsp_sec
      use ..\ruotsi\ncsp_koo alias ncsp_sec
      set order to code
      select ncsp_koo
      set relation to trim(code_swe) into ncsp_sec
      replace apu.swedish with ncsp_sec.text
      replace apu.mapp_swe with ncsp_sec.ncsp
      replace apu.use_swe with ncsp_sec.usedate
      replace apu.cha_swe with ncsp_sec.chadate
      replace apu.rel_swe with ncsp_sec.reldate
    endif
    if ncsp_koo.code_den<>' '
      p_kieli='Dan'
      select ncsp_sec
      use ..\tanska\ncsp_koo alias ncsp_sec
      set order to code
      select ncsp_koo
      set relation to trim(code_den) into ncsp_sec
      replace apu.danish with ncsp_sec.text
      replace apu.mapp_dan with ncsp_sec.ncsp
      replace apu.use_dan with ncsp_sec.usedate
      replace apu.cha_dan with ncsp_sec.chadate
      replace apu.rel_dan with ncsp_sec.reldate
    endif
    if ncsp_koo.code_nor<>' '
      p_kieli='Nor'
      select ncsp_sec
      use ..\norja\ncsp_koo alias ncsp_sec
      set order to code
      select ncsp_koo
      set relation to trim(code_nor) into ncsp_sec
      replace apu.norwegian with ncsp_sec.text
      replace apu.mapp_nor with ncsp_sec.ncsp
      replace apu.use_nor with ncsp_sec.usedate
      replace apu.cha_nor with ncsp_sec.chadate
      replace apu.rel_nor with ncsp_sec.reldate
    endif
    if ncsp_koo.code_est<>' '
      p_kieli='Est'
      select ncsp_sec
      use ..\eesti\ncsp_koo alias ncsp_sec
      set order to code
      select ncsp_koo
      set relation to trim(code_est) into ncsp_sec
      replace apu.estonian with ncsp_sec.text
      replace apu.mapp_est with ncsp_sec.ncsp
      replace apu.use_est with ncsp_sec.usedate
      replace apu.cha_est with ncsp_sec.chadate
      replace apu.rel_est with ncsp_sec.reldate
    endif
    if ncsp_koo.code_ice<>' '
      p_kieli='Ice'
      select ncsp_sec
      use ..\islanti\ncsp_koo alias ncsp_sec
      set order to code
      select ncsp_koo
      set relation to trim(code_ice) into ncsp_sec
      replace apu.icelandic with ncsp_sec.text
      replace apu.mapp_ice with ncsp_sec.ncsp
      replace apu.use_ice with ncsp_sec.usedate
      replace apu.cha_ice with ncsp_sec.chadate
      replace apu.rel_ice with ncsp_sec.reldate
    endif
    if ncsp_koo.code_lat<>' '
      p_kieli='Lat'
      select ncsp_sec
      use ..\latvia\ncsp_koo alias ncsp_sec
      set order to code
      select ncsp_koo
      set relation to trim(code_lat) into ncsp_sec
      replace apu.latvian with ncsp_sec.text
      replace apu.mapp_lat with ncsp_sec.ncsp
      replace apu.use_lat with ncsp_sec.usedate
      replace apu.cha_lat with ncsp_sec.chadate
      replace apu.rel_lat with ncsp_sec.reldate
    endif
    if ncsp_koo.code_eng<>' '
      p_kieli='Eng'
      select ncsp_sec
      use ..\englanti\ncsp_koo alias ncsp_sec
      set order to code
      select ncsp_koo
      set relation to trim(code_eng) into ncsp_sec
      replace apu.english with ncsp_sec.text
      replace apu.mapp_eng with ncsp_sec.ncsp
      replace apu.use_eng with ncsp_sec.usedate
      replace apu.cha_eng with ncsp_sec.chadate
      replace apu.rel_eng with ncsp_sec.reldate
    endif
    if ncsp_koo.ncsp=' '
      replace apu.mapp with ncsp_sec.ncsp
    endif
    select ncsp_koo
    skip
  enddo
  select apu
  replace all c1 with substr(ord,1,1), c2 with substr(ord,2,1), c3 with substr(ord,3,1), c4 with substr(ord,4,1),;
  c5 with substr(ord,5,1), c6 with substr(ord,6,1), code_eng2 with code_eng, code_den2 with code_den, code_est2 with code_est;
  code_fin2 with code_fin, code_nor2 with code_nor, code_swe2 with code_swe, code_lat2 WITH code_lat
  SET SAFETY OFF 
  copy to ..\ncsp_plus.dbf type foxplus
  copy to c:\data\ncsp_plus.dbf type foxplus
  COPY TO ..\text\ncsp_plus.txt sdf  
  SET SAFETY ON 
  use
  select ncsp_koo
  goto top
  do ..\gemens\_ncsp
  return

