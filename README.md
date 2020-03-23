Detta är ett inofficiellt projekt som försöker modellera data från det Svenska Intensivvårdsregistet.

Jag är en glad amatör som precis börjat lära mig R, så lita inte på något av detta utan verifiera allt med experter först. Jag har dock inte sett några liknande modeller från några myndigheter, så jag tänkte att det kanske behövs en dålig modell först som de förhoppningsvis åtminstone kan konstruktivt kritisera.

Hypotesen är att behovet av antal intensivvårdsplatser borde till en början vara exponentiellt.

![SIR modell](https://github.com/joelonsql/sir/blob/master/sir.png?raw=true "SIR modell")

Modellen är byggd i R. För er som har koll på statistik borde förhoppningsvis nedanstående säga er något. Min amatörmässiga uppfattning är att datapunkterna mycket väl korrelerar med en exponentiell funktion.

```
Call:
lm(formula = log2(IVAFall) ~ Dag, data = data)

Residuals:
    Min      1Q  Median      3Q     Max 
-0.3367 -0.1820  0.0273  0.1642  0.3746 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  0.90522    0.10530   8.597 3.51e-07 ***
Dag          0.34735    0.01028  33.802 1.42e-15 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.2076 on 15 degrees of freedom
Multiple R-squared:  0.987,	Adjusted R-squared:  0.9862 
F-statistic:  1143 on 1 and 15 DF,  p-value: 1.423e-15
```

