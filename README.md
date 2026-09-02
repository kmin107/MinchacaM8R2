# Confianza social e institucional - European Social Survey (ESS Round 11)

Proyecto para el Reto 2 del Módulo 8 (Investigación Reproducible). Uso el
mismo dataset y el mismo análisis del Reto 1, pero ahora armado como
proyecto reproducible completo: dashboard, informe y presentación
generados con código.

## Objetivo

Explorar las diferencias en confianza social, confianza institucional y
comportamiento digital entre los países del European Social Survey
(Round 11), mediante un dashboard interactivo.

Objetivos específicos:

- Describir la confianza interpersonal (`ppltrst`) y compararla entre los
  países con más participantes.
- Comparar la confianza institucional entre países, tanto en el
  parlamento (`trstprl`) como en la policía (`trstplc`).
- Ver si hay relación entre confianza interpersonal y confianza en el
  parlamento a nivel individual.
- Explorar el uso de internet (`netusoft`) y la participación electoral
  (`vote`) por país.

## Estructura

- `data/raw/`: el csv original del ESS, sin tocar.
- `data/processed/`: `ess_limpio.csv`, el resultado del script de
  limpieza. No lo edito a mano.
- `scripts/01_carga_depuracion.R`: carga el dataset, selecciona las
  variables que uso y recodifica los códigos especiales del ESS como NA.
- `dashboard/app.R`: dashboard en Shiny, filtro por país + un gráfico por
  cada variable clave.
- `report/informe.Rmd`: informe con knitr, tabla + gráfico + resultados
  calculados en vivo.
- `presentation/presentacion.Rmd`: la presentación en beamer con los
  hallazgos.

## Cómo correrlo

1. Abrir el proyecto en RStudio.
2. Correr `scripts/01_carga_depuracion.R` primero (si no, el dashboard y
   los informes no encuentran el csv limpio).
3. `shiny::runApp("dashboard")` para el dashboard.
4. `rmarkdown::render("report/informe.Rmd")` para el informe.
5. `rmarkdown::render("presentation/presentacion.Rmd")` para la
   presentación.

## Fuente de datos

European Social Survey. (2024). *ESS11 - integrated file, edition 4.2*
[Data set]. Sikt - Norwegian Agency for Shared Services in Education and
Research. https://ess.sikt.no/en/series/321b06ad-1b98-4b7d-93ad-ca8a24e8788a
