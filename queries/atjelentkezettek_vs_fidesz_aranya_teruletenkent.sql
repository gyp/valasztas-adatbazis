SELECT 
	szavf.maz, szavf.taz,
	telep.tnevi AS varos,
	tlista.tnev AS lista,
	SUM(szavt.szav) AS szavazatok,
	AVG(cast(szavt.szav AS float) / cast(szavf.n as float) * 100) AS fidesz_aranya,
	SUM(szavf.f) AS helyi_megjelentek_szama,
	SUM(szavf.g) AS atjelentkezett_megjelentek_szama,
	AVG(cast(szavf.g as float) / cast(szavf.g + szavf.f as float) * 100) AS  atjelentkezettek_aranya
FROM szavf
  JOIN szavt ON szavf.jfid = szavt.jfid
  JOIN tlista ON szavt.jlid = tlista.tlid
  JOIN telep ON  (szavf.maz = telep.maz AND szavf.taz = telep.taz)
WHERE
  szavf.valtip = 'L'
  AND lista='FIDESZ-KDNP'
GROUP BY
   szavf.maz, szavf.taz
  ;