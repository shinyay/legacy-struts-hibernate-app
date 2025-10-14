#!/bin/bash

echo "=== Starting Java 5 Legacy Application Services ==="

# アプリケーションをビルド
echo "Building application..."
cd /app
ant clean build

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
else
    echo "❌ Build failed!"
    exit 1
fi

# Docker Composeでサービス起動
echo "Starting services..."
docker-compose up -d tomcat mysql

# サービス起動確認
echo "Waiting for services to start..."
sleep 10

# Tomcatの起動確認
if curl -f http://localhost:8081 > /dev/null 2>&1; then
    echo "✅ Tomcat is running on port 8081"
else
    echo "⚠️  Tomcat may still be starting..."
fi

# MySQLの起動確認
if docker-compose exec mysql mysql -u root -prootpassword -e "SELECT 1;" > /dev/null 2>&1; then
    echo "✅ MySQL is running"
else
    echo "⚠️  MySQL may still be starting..."
fi

echo ""
echo "=== Services Started ==="
echo "🌐 Application: http://localhost:8081/legacy-app"
echo "🗄️  Database Admin: http://localhost:8082"
echo "📊 Services Status:"
docker-compose ps

echo ""
echo "=== Development Environment Ready! ==="
