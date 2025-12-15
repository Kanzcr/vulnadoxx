FROM eclipse-temurin:8-jdk

WORKDIR /app

COPY target/vulnado-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]