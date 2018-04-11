-- tothjutka
-- http://tothjutka.tumblr.com/post/172806899750/v%C3%A1laszt%C3%A1si-sqlmata
-- Ahol magas az “Átjelentkezett választópolgárok száma“ ott kimutathatóan magasabb a Fidesz szavazatainak aránya?

SELECT 
	telep.tnevi AS varos,
	szavf.sorsz AS sorszam,
	telep.tnevi || " - " || szavf.sorsz AS valasztokorzet,
	tlista.tnev AS lista,
	szavt.szav AS szavazatok,
	cast(szavt.szav AS float) / cast(szavf.n as float) * 100 AS fidesz_aranya_valasztokorben,
	fidesz_aranya_teruletenkent.fidesz_aranya AS fidesz_aranya_teruleten,
	cast(szavt.szav AS float) / cast(szavf.n as float) * 100 - fidesz_aranya_teruletenkent.fidesz_aranya AS fidesz_aranya_diff,
	szavf.f AS helyi_megjelentek_szama,
	szavf.g AS atjelentkezett_megjelentek_szama,
	cast(szavf.g as float) / cast(szavf.g + szavf.f as float) * 100 AS  atjelentkezettek_aranya
FROM szavf
  JOIN szavt ON szavf.jfid = szavt.jfid
  JOIN tlista ON szavt.jlid = tlista.tlid
  JOIN telep ON  (szavf.maz = telep.maz AND szavf.taz = telep.taz)
  LEFT JOIN 
     (  SELECT 
			szavf.maz, szavf.taz,
			tlista.tnev AS terulet_lista,
			AVG(cast(szavt.szav AS float) / cast(szavf.n as float) * 100) AS fidesz_aranya
		FROM szavf
		  JOIN szavt ON szavf.jfid = szavt.jfid
		  JOIN tlista ON szavt.jlid = tlista.tlid
		WHERE
		  szavf.valtip = 'L'
		  AND terulet_lista='FIDESZ-KDNP'
		GROUP BY
		   szavf.maz, szavf.taz
	  ) AS fidesz_aranya_teruletenkent ON (szavf.maz = fidesz_aranya_teruletenkent.maz AND szavf.taz = fidesz_aranya_teruletenkent.taz)
WHERE
  szavf.valtip = 'L'
  AND lista='FIDESZ-KDNP'
ORDER BY
  fidesz_aranya_diff DESC
  ;