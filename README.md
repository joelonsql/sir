Detta är ett inofficiellt projekt som försöker modellera data från det Svenska Intensivvårdsregistet:

![SIR url](https://github.com/joelonsql/sir/blob/master/sirurl.png?raw=true "SIR url")

SIR blir ofta överbelastat, så länken ovan är en bild för att reducera antalet onödiga besök. Undika att besöka SIR om det inte är absolut nödvändigt.

Jag är en glad amatör som precis börjat lära mig R, så lita inte på något av detta utan verifiera allt med experter först. Jag har dock inte sett några liknande modeller från några myndigheter, så jag tänkte att det kanske behövs en dålig modell först som de förhoppningsvis åtminstone kan konstruktivt kritisera.

Hypotesen är att behovet av antal intensivvårdsplatser borde till en början vara exponentiellt.

![SIR modell Linear scale](https://github.com/joelonsql/sir/blob/master/b5eb3caada69ce37812514187599779ba5042910.png?raw=true "SIR modell Linear scale")
![SIR modell Logarithmic scale](https://github.com/joelonsql/sir/blob/master/c31d5996808bb8cf8800e22a8e4a442d7c99e2db.png?raw=true "SIR modell Logarithmic scale")

Modellen är byggd i R. För er som har koll på statistik borde förhoppningsvis nedanstående säga er något. Min amatörmässiga uppfattning är att datapunkterna mycket väl korrelerar med en exponentiell funktion.

```
Call:
lm(formula = log2(IVAFall) ~ Dag, data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.35876 -0.13618  0.02143  0.09068  0.42063 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 0.808206   0.096507   8.375 4.88e-07 ***
Dag         0.364364   0.009418  38.687  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.1902 on 15 degrees of freedom
Multiple R-squared:  0.9901,	Adjusted R-squared:  0.9894 
F-statistic:  1497 on 1 and 15 DF,  p-value: < 2.2e-16
```

