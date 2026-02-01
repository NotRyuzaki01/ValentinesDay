# Use Java 17 (recommended for Spring Boot)
FROM eclipse-temurin:17-jdk

# App directory
WORKDIR /app

# Copy everything
COPY . .

# Build the JAR
RUN ./mvnw clean package -DskipTests

# Expose Render port
EXPOSE 8080

# Run the app
CMD ["java", "-jar", "target/*.jar"]
