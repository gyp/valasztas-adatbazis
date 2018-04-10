SELECT 
	telep.tnevi AS varos,
	szavf.sorsz AS sorszam,
	telep.tnevi || " - " || szavf.sorsz AS valasztokorzet,
	szavf.valtip AS szavazat_tipus,
	szavf.n AS ervenyes_szavazolapok,
    szavf.m AS ervenytelen_szavazolapok,
	cast(szavf.m as float) / cast(szavf.m + szavf. n as float) * 100 AS  ervenytelen_arany
FROM szavf
  JOIN telep ON  (szavf.maz = telep.maz AND szavf.taz = telep.taz)
ORDER BY ervenytelen_arany DESC
  ;