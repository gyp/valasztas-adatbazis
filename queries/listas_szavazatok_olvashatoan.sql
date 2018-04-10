SELECT 
	telep.tnevi AS varos,
	szavf.sorsz AS sorszam,
	telep.tnevi || " - " || szavf.sorsz AS valasztokorzet,
	tlista.tnev AS lista,
	szavt.szav AS szavazatok
FROM szavf
  JOIN szavt ON szavf.jfid = szavt.jfid
  JOIN tlista ON szavt.jlid = tlista.tlid
  JOIN telep ON  (szavf.maz = telep.maz AND szavf.taz = telep.taz)
WHERE
  szavf.valtip = 'L'
 
  ;
