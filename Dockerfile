# Build stage
FROM eclipse-temurin:17-jdk AS builder

WORKDIR /app

# Copy Maven wrapper files (cache deps better)
COPY pom.xml mvnw ./
COPY .mvn .mvn/
RUN chmod +x mvnw && ./mvnw dependency:go-offline -B

# Copy source code and build
COPY src ./src
RUN ./mvnw clean package -DskipTests -B

# Production stage (JRE for smaller image)
FROM eclipse-temurin:17-jre

WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

# Render sets $PORT automatically
ENTRYPOINT ["java", "-jar", "app.jar"]
