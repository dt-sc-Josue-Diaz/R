# ggplot2, b�sicos.

# Instalacion de la libreria 
# install.packages('tidyverse')


# Cargar librerias 
library(tidyverse)
library(readxl)


# seccion de trabajo
setwd("C:/Users/luisj/Dropbox/Ciencia_de_datos/Portafolio/R/03_ggplot")

# Datos datos excel. Base de datos del inegi, muestreo de los ingresos 
# de las personas

enoe <- read_xlsx("mu_enoe.xlsx")

# Conocer el tipo de datos.
class(enoe)
# Obsevaciones vs variables
dim(enoe)

#nombres de las  variables
colnames(enoe)

# Gr�ficas en ggplot

# En este caso estamos viendo si hay correlacion entre a�os de escolaridad 
# con el ingreso mensual. 

ggplot( data = enoe) + 
  geom_point(mapping = aes(x = anios_esc, y = ingreso_mensual))

# modificaiones

ggplot( data = enoe) + 
  geom_point(mapping = aes(x = anios_esc, y = ingreso_mensual), color = "blue")

# Mapeos est�ticos
# identificar empleos formales contra informales por medio de color.

ggplot( data = enoe) + 
  geom_point(mapping = aes(x = anios_esc, y = ingreso_mensual, color = tipo_empleo))

# identificar empleos formales contra informales por medio de formas distintas

ggplot( data = enoe) + 
  geom_point(mapping = aes(x = anios_esc, y = ingreso_mensual, shape = tipo_empleo))


# Comparamos a a�os de escolaridad vs edad. Identificamos ahora por medio 
# del ingreso mensual por una escala de transparencias. Esta no es una buena
# gr�fica. 

# ggplot( data = enoe) + 
#  geom_point(mapping = aes(x = anios_esc, y = edad, alpha = ingreso_mensual))

# ggplot trabaja en capas
ggplot( data = enoe) + # capa 1
  geom_point(mapping = aes(x = anios_esc, y = ingreso_mensual), color = "blue") + #capa 2
  geom_smooth(aes(anios_esc,ingreso_mensual)) # tercera capa. 


# Separar por facetas.

# facet_wrap. Esta gr�fica nos separa por sexo los datos a�os de escolaridad
# contra ingreso mensual, identificada por tipo de empleo por color. 
ggplot( data = enoe) + 
  geom_point(mapping = aes(x = anios_esc, y = ingreso_mensual, color = tipo_empleo)) +
  facet_wrap(~sex, nrow=1, ncol=2)

# facet_grid
ggplot( data = enoe) + 
  geom_point(mapping = aes(x = anios_esc, y = ingreso_mensual, color = tipo_empleo)) +
  facet_grid(tipo_empleo~sex)

# Comparemos dos datos con dos tipos distintos de gr�ficos
# Gr�fico 1
ggplot( data = enoe) + 
  geom_point(mapping = aes(x = anios_esc, y = ingreso_mensual), color = "blue")
# Gr�fico 2
ggplot( data = enoe) + 
  geom_smooth(mapping = aes(x = anios_esc, y = ingreso_mensual), color = "blue")

# Tambien podemos separar una gr�fica de curvas
ggplot( data = enoe) + 
  geom_smooth(mapping = aes(x = anios_esc, y = ingreso_mensual, linetype = sex))
# Sin embargo no todas las modificaciones se pueden hacer.

# Combinar gr�ificas. 
ggplot( data = enoe, mapping = aes(x = anios_esc, y = ingreso_mensual)) + 
  geom_smooth( mapping = aes(linetype = tipo_empleo)) +
  geom_point(mapping = aes(color = tipo_empleo))

# Esta gr�fica es importante, ya que nos puede resultar enga�oso la tendencia de que
# entre mas a�os de escolaridad mayor ingreso mensual.

# Variacion de la grafica.
ggplot( data = enoe, mapping = aes(x = anios_esc, y = ingreso_mensual)) + 
  geom_smooth(data = filter(enoe, estado == "Jalisco"), se = FALSE) +
  geom_point(mapping = aes(color = niv_edu), show.legend = FALSE)
# En esta grafica los puntos son los datos del todo el pais, pero la linea los 
# datos de Jalisco. 


# Transformaciones est�diticas. 

# Grafica de barras por sexo
ggplot( data = enoe) + 
  geom_bar(mapping = aes(x = sex, y=..prop.., group = 1))

ggplot( data = enoe) + 
  stat_count(mapping = aes(x = sex))

# Estas dos grafcas son similares, pero la ultima es una transformacion 
# estad�stica asociada a las graficas de barras. 

ggplot(data = enoe) + stat_summary(
  mapping = aes(x = sex, y = ingreso_mensual),
  fun.min = min,
  fun.max = max,
  fun = median
)
# Estas graficas nos permiten hacer un analisis estad�stco con el grafico. 

# Grafica de barras apiladas
ggplot(data = enoe) + 
  geom_bar(mapping = aes(x = sex, fill = sex))
  
ggplot(data = enoe) + 
  geom_bar(mapping = aes(x = sex, fill = niv_edu))

ggplot(data = enoe, mapping = aes(x = sex, fill = niv_edu)) +
  geom_bar(position = "fill")
# En este caso se aprecia mejor ya que la categoria esta a 100 porciento
# tanto de hombres y de mujeres. Que es mejor que la gr�fica previa. 

ggplot(data = enoe, mapping = aes(x = sex, fill = niv_edu)) +
  geom_bar(position = "dodge") + labs(title = "Sexo y nivel educativo", x = "Sexo", y = "Observaciones")
# dodge pone una al lado de otra.

# jitter
ggplot( data = enoe) + 
  geom_point(mapping = aes(x = anios_esc, y = ingreso_mensual), position = "jitter")

# Sistema de coordenadas. 
# Diagrama de caja y bigotes.
ggplot(data = enoe, mapping = aes(x = niv_edu, y = ingreso_mensual), position = "jitter") + 
  geom_boxplot() + coord_flip()
# Rotar un boxplot

# Coordenadas polares para hacer gr�ficos de pastel. 

barras <- ggplot(data = enoe) + geom_bar(mapping = aes(x = niv_edu, fill = niv_edu),
                               show.legend = FALSE, width = 1) + 
  theme(aspect.ratio = 1) + 
  labs(x = NULL, y = NULL)

# Esta es una gr�fica de coordenas polares. 
barras + coord_polar()

# Esta es una gr�fia de pastel.
ggplot(data = enoe, mapping = aes(x = factor(1), fill = niv_edu)) + 
  geom_bar(position = "fill") + 
  coord_polar(theta = "y") + 
  labs(x = " ", y = " ")
