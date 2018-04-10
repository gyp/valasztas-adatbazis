-- tothjutka
-- http://tothjutka.tumblr.com/post/172806899750/v%C3%A1laszt%C3%A1si-sqlmata
-- Ahol magas az “Átjelentkezett választópolgárok száma“ ott kimutathatóan magasabb a Fidesz szavazatainak aránya?

SELECT 
	telep.tnevi AS varos,
	szavf.sorsz AS sorszam,
	telep.tnevi || " - " || szavf.sorsz AS valasztokorzet,
	tlista.tnev AS lista,
	szavt.szav AS szavazatok,
	cast(szavt.szav AS float) / cast(szavf.n as float) * 100 AS fidesz_aranya,
	szavf.f AS helyi_megjelentek_szama,
	szavf.g AS atjelentkezett_megjelentek_szama,
	cast(szavf.g as float) / cast(szavf.g + szavf.f as float) * 100 AS  atjelentkezettek_aranya
FROM szavf
  JOIN szavt ON szavf.jfid = szavt.jfid
  JOIN tlista ON szavt.jlid = tlista.tlid
  JOIN telep ON  (szavf.maz = telep.maz AND szavf.taz = telep.taz)
WHERE
  szavf.valtip = 'L'
  AND lista='FIDESZ-KDNP'
  ;