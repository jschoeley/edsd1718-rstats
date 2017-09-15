Assignment 1
================
Jonas Schöley
September 13, 2017

1.  Register at <http://www.mortality.org/>.
2.  Download single year, single period death counts and exposures for a country of your choice.
3.  *For each year in the data*, calculate life expectancy at birth[1] and the coefficient of variation of the life-table distribution of deaths.

You can calculate the coefficient of variation for a life-table as

$$
\\widehat{\\text{CV}} = \\frac {\\sqrt{\\sum\_{x=0}^\\omega {}\_nd\_x(\\overline{x}-e\_0)^2}} {e\_0} = \\frac {\\sqrt{\\sum\_{x=0}^\\omega {}\_nd\_x(x+{}\_na\_x-e\_0)^2}} {e\_0},
$$

with <sub>*n*</sub>*a*<sub>*x*</sub> ≈ 0.5*n*<sub>*x*</sub>.

(Bored? How about fitting a spline to the ℓ<sub>*x*</sub> values of the life-table using `splinefun()` and use the continuous formula 7 with the fitted spline and numerical integration (`integrate()`) to calculate the Gini coefficient? No pressure though.)

1.  Show the relationship among life-expectancy and the coefficient of variation of the life-table distribution of deaths. What do you see? If you have an explanation for the relationship I would be interested in reading about it.

References
----------

Preston, Samuel. 2001. *Demography. Measuring and Modeling Population Processes.* Blackwell Publishers.

[1] See Preston (2001, 49, Box 3.1)
