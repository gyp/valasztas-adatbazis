SELECT 
	telep.tnevi AS varos,
	szavf.sorsz AS sorszam,
	telep.tnevi || " - " || szavf.sorsz AS valasztokorzet,
	ejelolt.nev || " " || ejelolt.unev1 AS nev,
	jlcs.nevt AS jelolo_szervezet,
	szavt.szav AS szavazatok
FROM szavf
  JOIN szavt ON szavf.jfid = szavt.jfid
  JOIN ejelolt ON szavt.jlid = ejelolt.eid
  LEFT JOIN jlcs ON jlcs.jlcs = ejelolt.jlcs
  JOIN telep ON  (szavf.maz = telep.maz AND szavf.taz = telep.taz)
WHERE
  szavf.valtip = 'J'
  ;