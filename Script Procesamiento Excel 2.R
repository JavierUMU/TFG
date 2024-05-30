# Instala los paquetes necesarios si no los tienes instalados
install.packages("readxl")
install.packages("dplyr")
install.packages("tidyr")
install.packages("writexl")

# Cargar las librerías necesarias
library(readxl)
library(dplyr)
library(tidyr)
library(writexl)

# Leer los datos desde el archivo CSV
# Reemplaza 'ruta_del_archivo.csv' con la ruta real de tu archivo CSV
datos <- read_csv("Completo_caracter.csv")

# Definir las categorías de las columnas
column_categories <- data.frame(
  Nombre = c('FI', 'FP', 'FLINT', 'FF', 'BI', 'BP', 'BOINT', 'FL-DESMAYO', 'FL-FERRAGNES',
             'FL-PENTA', 'FL-TARDONA', 'FL-S5133', 'FL-ACHAAK', 'FL-R1000', 'FRUTO',
             'CASCA', 'CASC1', 'DUREZ', 'GRANO', 'GRAN1', 'RENDI', 'FALLO', 'FALLP',
             'DOBLE', 'DOBLP', 'DEFEC', 'DEFEP', 'DEFET', 'FORMA', 'ESPES', 'RUGOS',
             'COLOR', 'SABOR', 'NOTA', 'PRINT', 'MADUR', 'MOCRE', 'AUTPI', 'AUTFR', 'AC', 'AUTPC'),
  Tipo_dato = c('INT', 'INT', 'INT', 'INT', 'INT', 'INT', 'INT', 'INT', 'INT', 'INT', 'INT', 
                'INT', 'INT', 'INT', 'INT', 'INT', 'INT', 'INT', 'INT', 'INT', 'INT', 
                'FLOAT', 'FLOAT', 'FLOAT', 'FLOAT', 'FLOAT', 'FLOAT', 'FLOAT', 'INT', 
                'INT', 'INT', 'INT', 'INT', 'VARCHAR(10)', 'INT', 'INT', 'INT', 'VARCHAR(10)', 
                'VARCHAR(10)', 'VARCHAR(10)', 'VARCHAR(10)'),
  Tipo_caracter = c(rep('Fenologico', 14), rep('Fruto', 19), rep('Produccion', 3), rep('Compatibilidad', 4))
)

# Transformar los datos al formato largo (long format)
datos_long <- datos %>%
  pivot_longer(cols = -c(idArbol, Año), names_to = "Nombre", values_to = "Valor") %>%
  drop_na(Valor) %>%
  left_join(column_categories, by = "Nombre") %>%
  mutate(idcaracter_arbol = NA) %>%
  rename(arbol_idarbol = idArbol)

# Reordenar las columnas
datos_long <- datos_long %>%
  select(idcaracter_arbol, Año, Nombre, Tipo_dato, Tipo_caracter, Valor, arbol_idarbol)

# Mostrar el DataFrame resultante
print(datos_long)

# Guardar el DataFrame en un nuevo archivo Excel o CSV
write_xlsx(datos_long, "datos_transformados.xlsx")
write_csv(datos_long, "datos_transformados.csv")