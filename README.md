Detta är ett inofficiellt projekt som försöker modellera data från det Svenska Intensivvårdsregistet:

![SIR url](https://github.com/joelonsql/sir/blob/master/sirurl.png?raw=true "SIR url")

SIR blir ofta överbelastat, så länken ovan är en bild för att reducera antalet onödiga besök. Undika att besöka SIR om det inte är absolut nödvändigt. Besök istället någon av sidorna som cachear dess data, såsom [https://c19.se/](https://c19.se/) där SIR-data snart kommer att publiceras om det inte redan är gjort.

Jag är en glad amatör som precis börjat lära mig R, så lita inte på något av detta utan verifiera allt med experter först. Jag har dock inte sett några liknande modeller från några myndigheter, så jag tänkte att det kanske behövs en dålig modell först som de förhoppningsvis åtminstone kan konstruktivt kritisera.

Hypotesen är att behovet av antal intensivvårdsplatser borde till en början vara exponentiellt.

![SIR modell Linear scale](https://github.com/joelonsql/sir/blob/master/80cde552f04f89b6a74f84f49f2ca48fe636e410.png?raw=true "SIR modell Linear scale")
![SIR modell Logarithmic scale](https://github.com/joelonsql/sir/blob/master/5915da4c322fdef299c4fc2960ff47af026ad20c.png?raw=true "SIR modell Logarithmic scale")

Modellen är byggd i R. För er som har koll på statistik borde förhoppningsvis nedanstående säga er något. Min amatörmässiga uppfattning är att datapunkterna mycket väl korrelerar med en exponentiell funktion.

```
Call:
lm(formula = log2(IVAFall) ~ Dag, data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.35732 -0.08314  0.03796  0.10131  0.41286 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 0.822875   0.095598   8.608 3.46e-07 ***
Dag         0.362064   0.009329  38.809  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.1884 on 15 degrees of freedom
Multiple R-squared:  0.9901,	Adjusted R-squared:  0.9895 
F-statistic:  1506 on 1 and 15 DF,  p-value: < 2.2e-16
```

