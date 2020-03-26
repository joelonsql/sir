Detta är ett inofficiellt projekt som försöker modellera data från det Svenska Intensivvårdsregistet:

![SIR url](https://github.com/joelonsql/sir/blob/master/sirurl.png?raw=true "SIR url")

SIR blir ofta överbelastat, så länken ovan är en bild för att reducera antalet onödiga besök. Undika att besöka SIR om det inte är absolut nödvändigt.

Jag är en glad amatör som precis börjat lära mig R, så lita inte på något av detta utan verifiera allt med experter först. Jag har dock inte sett några liknande modeller från några myndigheter, så jag tänkte att det kanske behövs en dålig modell först som de förhoppningsvis åtminstone kan konstruktivt kritisera.

# Hypotes 1

Hypotesen är att behovet av antal intensivvårdsplatser borde till en början vara exponentiellt.

![SIR modell Linear scale](https://github.com/joelonsql/sir/blob/master/sir_lin_2020-03-26.png?raw=true "SIR modell Linear scale")
![SIR modell Logarithmic scale](https://github.com/joelonsql/sir/blob/master/sir_log_2020-03-26.png?raw=true "SIR modell Logarithmic scale")

Modellen är byggd i R. För er som har koll på statistik borde förhoppningsvis nedanstående säga er något. Min amatörmässiga uppfattning är att datapunkterna mycket väl korrelerar med en exponentiell funktion.

```
Call:
lm(formula = log2(IVAFall) ~ Dag, data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.35809 -0.08697  0.02573  0.07450  0.41834 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 0.812711   0.085129   9.547 3.04e-08 ***
Dag         0.363626   0.007466  48.702  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.1783 on 17 degrees of freedom
Multiple R-squared:  0.9929,	Adjusted R-squared:  0.9925 
F-statistic:  2372 on 1 and 17 DF,  p-value: < 2.2e-16
```

# Hypotes 2

Nästa hypotes är att många av de som vårdas på intensivvård skulle ha dött om de inte fått intensivvård.
När/om Sverige får slut på intensivvårdplatser så kommer de fall som annars skulle blivit intensivvårdsfall istället att bli dödsfall.
För att kunna uppskatta framtida behov av intensivvård tänker jag därför att man borde summera dödsfall och intensivvårdsfall, och utgår från att den utvecklingen är exponentiell.

![SIR2](https://github.com/joelonsql/sir/blob/master/sir2_2020-03-26.png?raw=true "SIR2")

```
Call:
lm(formula = log2(cumsum(icu + deaths)) ~ days)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.30090 -0.07536  0.01117  0.10304  0.36873 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 0.814988   0.078680   10.36 9.22e-09 ***
days        0.379405   0.006901   54.98  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.1648 on 17 degrees of freedom
Multiple R-squared:  0.9944,	Adjusted R-squared:  0.9941 
F-statistic:  3023 on 1 and 17 DF,  p-value: < 2.2e-16
```
