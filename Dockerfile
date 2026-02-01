# Build stage
FROM eclipse-temurin:17-jdk AS builder

WORKDIR /app

# Copy Maven files first for caching
COPY pom.xml .
COPY mvnw .mvn .mvn/ ./  # Assumes .mvn dir exists
RUN chmod +x mvnw

# Download dependencies
RUN ./mvnw dependency:go-offline -B

# Copy source and build
COPY src ./src
RUN ./mvnw clean package -DskipTests -B

# Runtime stage (smaller image)
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy JAR from builder
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 10000  # Render dynamic port (not 8080)

ENTRYPOINT ["java", "-jar", "app.jar"]
