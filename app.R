# app.R
# Dashboard - Confianza social e institucional (ESS Round 11)
#
# Filtro de país arriba, gráficos abajo. Nada muy sofisticado, pero
# cubre lo que pide el reto. Necesita el csv que genera
# scripts/01_carga_depuracion.R, así que hay que correr ese script
# primero o esto no va a encontrar el archivo.

library(shiny)
library(ggplot2)

ess <- read.csv("../data/processed/ess_limpio.csv", stringsAsFactors = FALSE)

lista_paises <- sort(unique(ess$cntry))

mi_color <- "#8E44AD"  # mismo morado en todos los gráficos (Gestalt, Reto 1)


ui <- fluidPage(

  titlePanel("Dashboard - Confianza social e institucional (ESS Round 11)"),

  sidebarLayout(
    sidebarPanel(
      selectInput("pais", "Selecciona un país:",
                  choices = c("Todos", lista_paises),
                  selected = "Todos"),
      helpText("Al cambiar el país, los gráficos de abajo se actualizan solos.")
    ),

    mainPanel(
      h4("Confianza en las personas"),
      plotOutput("grafico_ppltrst"),

      h4("Confianza en el parlamento"),
      plotOutput("grafico_trstprl"),

      h4("Confianza en la policía"),
      plotOutput("grafico_trstplc"),

      h4("Uso de internet"),
      plotOutput("grafico_internet"),

      h4("Participación en votaciones"),
      plotOutput("grafico_vote")
    )
  )
)


server <- function(input, output) {

  datos_pais <- reactive({
    if (input$pais == "Todos") {
      ess
    } else {
      ess[ess$cntry == input$pais, ]
    }
  })

  output$grafico_ppltrst <- renderPlot({
    df <- datos_pais()
    df <- df[!is.na(df$ppltrst), ]
    ggplot(df, aes(x = ppltrst)) +
      geom_bar(fill = mi_color) +
      labs(x = "Nivel de confianza (0 = nada, 10 = mucho)", y = "Número de personas") +
      theme_minimal()
  })

  output$grafico_trstprl <- renderPlot({
    df <- datos_pais()
    df <- df[!is.na(df$trstprl), ]
    ggplot(df, aes(x = trstprl)) +
      geom_bar(fill = mi_color) +
      labs(x = "Confianza en el parlamento (0-10)", y = "Número de personas") +
      theme_minimal()
  })

  # este panel lo agregué después, se me había quedado fuera y sí es
  # parte de los objetivos (comparar confianza en parlamento y policía)
  output$grafico_trstplc <- renderPlot({
    df <- datos_pais()
    df <- df[!is.na(df$trstplc), ]
    ggplot(df, aes(x = trstplc)) +
      geom_bar(fill = mi_color) +
      labs(x = "Confianza en la policía (0-10)", y = "Número de personas") +
      theme_minimal()
  })

  output$grafico_internet <- renderPlot({
    df <- datos_pais()
    df <- df[!is.na(df$netusoft), ]
    ggplot(df, aes(x = factor(netusoft))) +
      geom_bar(fill = mi_color) +
      labs(x = "Frecuencia de uso (1 = nunca, 5 = todos los días)", y = "Número de personas") +
      theme_minimal()
  })

  output$grafico_vote <- renderPlot({
    df <- datos_pais()
    df <- df[!is.na(df$vote), ]
    ggplot(df, aes(x = factor(vote))) +
      geom_bar(fill = mi_color) +
      labs(x = "Votó en la última elección (1 = sí, 2 = no, 3 = no podía)", y = "Número de personas") +
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)
