Detta är ett inofficiellt projekt som försöker modellera data från det Svenska Intensivvårdsregistet:

![SIR url](https://github.com/joelonsql/sir/blob/master/sirurl.png?raw=true "SIR url")

SIR blir ofta överbelastat, så länken ovan är en bild för att reducera antalet onödiga besök. Undika att besöka SIR om det inte är absolut nödvändigt. Besök istället någon av sidorna som cachear dess data, såsom [https://c19.se/](https://c19.se/) där SIR-data snart kommer att publiceras om det inte redan är gjort.

Jag är en glad amatör som precis börjat lära mig R, så lita inte på något av detta utan verifiera allt med experter först. Jag har dock inte sett några liknande modeller från några myndigheter, så jag tänkte att det kanske behövs en dålig modell först som de förhoppningsvis åtminstone kan konstruktivt kritisera.

Hypotesen är att behovet av antal intensivvårdsplatser borde till en början vara exponentiellt.

![SIR modell Linear scale](https://github.com/joelonsql/sir/blob/master/sir_20200323_lin.png?raw=true "SIR modell Linear scale")
![SIR modell Logarithmic scale](https://github.com/joelonsql/sir/blob/master/sir_20200323_log.png?raw=true "SIR modell Logarithmic scale")

Modellen är byggd i R. För er som har koll på statistik borde förhoppningsvis nedanstående säga er något. Min amatörmässiga uppfattning är att datapunkterna mycket väl korrelerar med en exponentiell funktion.

```
Call:
lm(formula = log2(IVAFall) ~ Dag, data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.33730 -0.18198  0.02853  0.15986  0.37650 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  0.90153    0.10380   8.685 3.09e-07 ***
Dag          0.34797    0.01013  34.349 1.12e-15 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.2046 on 15 degrees of freedom
Multiple R-squared:  0.9874,	Adjusted R-squared:  0.9866 
F-statistic:  1180 on 1 and 15 DF,  p-value: 1.122e-15
```

