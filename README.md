Detta är ett inofficiellt projekt som försöker modellera data från det Svenska Intensivvårdsregistet:

![SIR url](https://github.com/joelonsql/sir/blob/master/sirurl.png?raw=true "SIR url")

SIR blir ofta överbelastat, så länken ovan är en bild för att reducera antalet onödiga besök. Undika att besöka SIR om det inte är absolut nödvändigt.

Jag är en glad amatör som precis börjat lära mig R, så lita inte på något av detta utan verifiera allt med experter först. Jag har dock inte sett några liknande modeller från några myndigheter, så jag tänkte att det kanske behövs en dålig modell först som de förhoppningsvis åtminstone kan konstruktivt kritisera.

Hypotesen är att behovet av antal intensivvårdsplatser borde till en början vara exponentiellt.

![SIR modell Linear scale](https://github.com/joelonsql/sir/blob/master/292ae073dbd741995255b5ef34c9382553608ef9.png?raw=true "SIR modell Linear scale")
![SIR modell Logarithmic scale](https://github.com/joelonsql/sir/blob/master/15088df18b5b86ecbabdc460e537fc4377793bc6.png?raw=true "SIR modell Logarithmic scale")

Modellen är byggd i R. För er som har koll på statistik borde förhoppningsvis nedanstående säga er något. Min amatörmässiga uppfattning är att datapunkterna mycket väl korrelerar med en exponentiell funktion.

```
Call:
lm(formula = log2(IVAFall) ~ Dag, data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.35787 -0.10411  0.01890  0.08419  0.41932 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 0.811155   0.090174   8.995 1.17e-07 ***
Dag         0.363816   0.008331  43.672  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.1834 on 16 degrees of freedom
Multiple R-squared:  0.9917,	Adjusted R-squared:  0.9912 
F-statistic:  1907 on 1 and 16 DF,  p-value: < 2.2e-16
```

