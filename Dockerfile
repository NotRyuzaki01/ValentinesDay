# Build stage
FROM eclipse-temurin:17-jdk AS builder

WORKDIR /app

# Copy Maven files first for better layer caching
COPY pom.xml .
COPY mvnw .mvn/ .  # .mvn dir if present
RUN chmod +x mvnw

# Cache dependencies
RUN ./mvnw dependency:go-offline -B

# Copy source and build JAR
COPY src ./src
RUN ./mvnw clean package -DskipTests -B

# Production stage (uses JRE for smaller image)
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy built JAR
COPY --from=builder /app/target/*.jar app.jar

# Render uses dynamic $PORT (default 10000); no EXPOSE needed
ENTRYPOINT ["java", "-jar", "app.jar"]
