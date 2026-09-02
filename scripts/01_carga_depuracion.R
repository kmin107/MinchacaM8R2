# 01_carga_depuracion.R

# Cargo el ESS, me quedo con las variables que necesito y limpio los
# códigos raros del cuestionario (77, 88, 99...), que en realidad son
# "no sabe / no contesta" y no respuestas de verdad. Al final guardo
# todo en data/processed/ess_limpio.csv.

ess <- read.csv("data/raw/ESS11e04_2.csv", stringsAsFactors = FALSE)

cat("Filas cargadas:", nrow(ess), "\n")
cat("Columnas cargadas:", ncol(ess), "\n")

# variables que uso en el dashboard y en el informe (las mismas que
# justifiqué en el Reto 1)
mis_variables <- c("cntry", "ppltrst", "pplfair", "pplhlp",
                    "trstprl", "trstplc", "netusoft", "vote", "polintr")

ess_sel <- ess[, mis_variables]

# las variables de confianza van de 0 a 10, así que cualquier valor
# arriba de 10 es un código especial (no sabe, no contesta, rehúsa)
ess_sel$ppltrst[ess_sel$ppltrst > 10] <- NA
ess_sel$pplfair[ess_sel$pplfair > 10] <- NA
ess_sel$pplhlp[ess_sel$pplhlp > 10]   <- NA
ess_sel$trstprl[ess_sel$trstprl > 10] <- NA
ess_sel$trstplc[ess_sel$trstplc > 10] <- NA

ess_sel$netusoft[ess_sel$netusoft > 5] <- NA          # netusoft va de 1 a 5
ess_sel$vote[!(ess_sel$vote %in% c(1, 2, 3))] <- NA   # vote solo tiene 3 respuestas válidas
ess_sel$polintr[ess_sel$polintr > 4] <- NA            # polintr va de 1 a 4

# reviso los NA que quedaron, para confirmar que la limpieza sirvió
cat("\nValores perdidos por variable después de limpiar:\n")
print(colSums(is.na(ess_sel)))

dir.create("data/processed", showWarnings = FALSE)
write.csv(ess_sel, "data/processed/ess_limpio.csv", row.names = FALSE)

cat("\nListo, guardado en data/processed/ess_limpio.csv\n")
cat("Filas finales:", nrow(ess_sel), "\n")
