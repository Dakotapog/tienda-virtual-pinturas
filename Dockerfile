FROM maven:3.8.6-openjdk-11-slim AS build

# Establecer directorio de trabajo
WORKDIR /app

# Copiar archivos del proyecto
COPY pom.xml .
COPY src ./src

# Empaquetar la aplicación
RUN mvn clean package -DskipTests

# Crear imagen final con JRE
FROM openjdk:11-jre-slim

WORKDIR /app

# Copiar el JAR compilado desde la etapa de build
COPY --from=build /app/target/*.jar app.jar

# Exponer el puerto que usa la aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]