SELECT
    ervenytelen_egyeni.valasztokorzet,
	ervenytelen_listas.ervenytelen_szavazolapok AS ervenytelen_szavazolapok_listas,
	ervenytelen_egyeni.ervenytelen_szavazolapok AS ervenytelen_szavazolapok_egyeni,
	ervenytelen_listas.ervenytelen_szavazolapok - ervenytelen_egyeni.ervenytelen_szavazolapok AS ervenytelen_szavazolapok_diff
FROM
	(
		SELECT 
			telep.tnevi || " - " || szavf.sorsz AS valasztokorzet,
			szavf.valtip AS szavazat_tipus,
			szavf.n AS ervenyes_szavazolapok,
			szavf.m AS ervenytelen_szavazolapok,
			cast(szavf.m as float) / cast(szavf.m + szavf. n as float) * 100 AS  ervenytelen_arany
		FROM szavf
		  JOIN telep ON  (szavf.maz = telep.maz AND szavf.taz = telep.taz)
		WHERE szavf.valtip = 'L'
	) AS ervenytelen_listas
	JOIN
	(
		SELECT 
			telep.tnevi || " - " || szavf.sorsz AS valasztokorzet,
			szavf.valtip AS szavazat_tipus,
			szavf.n AS ervenyes_szavazolapok,
			szavf.m AS ervenytelen_szavazolapok,
			cast(szavf.m as float) / cast(szavf.m + szavf. n as float) * 100 AS  ervenytelen_arany
		FROM szavf
		  JOIN telep ON  (szavf.maz = telep.maz AND szavf.taz = telep.taz)
		  
		WHERE szavf.valtip = 'J'
	) AS ervenytelen_egyeni ON (ervenytelen_listas.valasztokorzet = ervenytelen_egyeni.valasztokorzet)
ORDER BY
	ABS(ervenytelen_szavazolapok_diff) DESC
LIMIT 100
;