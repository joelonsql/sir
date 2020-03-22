# sis
Detta är ett inofficiellt projekt som försöker modellera data från det Svenska Intensivvårdsregistet.

Hypotesen är att behovet av antal intensivvårdsplatser borde till en början vara exponentiellt.

Modellen är byggd i R. För er som har koll på statistik borde förhoppningsvis nedanstående säga er något. Min amatörmässiga uppfattning är att datapunkterna mycket väl korrelerar med en exponentiell funktion.

```
Call:
lm(formula = log2(IVAFall) ~ Dag, data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.34424 -0.14229  0.02434  0.11918  0.39733 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  0.85986    0.10200    8.43 7.41e-07 ***
Dag          0.35491    0.01055   33.65 8.55e-15 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.1945 on 14 degrees of freedom
Multiple R-squared:  0.9878,	Adjusted R-squared:  0.9869 
F-statistic:  1132 on 1 and 14 DF,  p-value: 8.549e-15
```

