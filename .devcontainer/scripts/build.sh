#!/bin/bash

# Java 5 Legacy Application Build Script
# このスクリプトはStruts 1.xアプリケーションのビルドを自動化します

set -e

echo "=== Java 5 Legacy Application Build Script ==="
echo "JAVA_HOME: $JAVA_HOME"
echo "ANT_HOME: $ANT_HOME"
echo "Current Directory: $(pwd)"

# 環境チェック
check_environment() {
    echo "--- Environment Check ---"

    if [ ! -d "$JAVA_HOME" ]; then
        echo "Error: JAVA_HOME is not set or directory does not exist: $JAVA_HOME"
        exit 1
    fi

    if ! command -v java &> /dev/null; then
        echo "Error: java command not found"
        exit 1
    fi

    if ! command -v javac &> /dev/null; then
        echo "Error: javac command not found"
        exit 1
    fi

    if ! command -v ant &> /dev/null; then
        echo "Error: ant command not found"
        exit 1
    fi

    echo "Java Version:"
    java -version
    echo
    echo "Ant Version:"
    ant -version
    echo
}

# ディレクトリ構造の確認と作成
setup_directories() {
    echo "--- Setting up directories ---"

    mkdir -p src/main/java
    mkdir -p src/main/resources
    mkdir -p src/main/webapp/WEB-INF
    mkdir -p src/test/java
    mkdir -p lib
    mkdir -p build/classes
    mkdir -p build/test-classes
    mkdir -p build/war
    mkdir -p dist
    mkdir -p docs

    echo "Directory structure created successfully."
}

# クリーンアップ
clean() {
    echo "--- Cleaning build artifacts ---"
    rm -rf build/*
    rm -rf dist/*
    echo "Clean completed."
}

# コンパイル
compile() {
    echo "--- Compiling Java sources ---"

    if [ ! -d "src/main/java" ]; then
        echo "Warning: src/main/java directory not found. Creating sample structure..."
        setup_directories
        return 0
    fi

    # Javaソースファイルがあるかチェック
    if ! find src/main/java -name "*.java" | grep -q .; then
        echo "No Java source files found in src/main/java"
        return 0
    fi

    # ライブラリのクラスパス構築
    CLASSPATH="."
    if [ -d "lib" ]; then
        for jar in lib/*.jar; do
            if [ -f "$jar" ]; then
                CLASSPATH="$CLASSPATH:$jar"
            fi
        done
    fi

    # WEB-INF/libのクラスパス構築
    if [ -d "src/main/webapp/WEB-INF/lib" ]; then
        for jar in src/main/webapp/WEB-INF/lib/*.jar; do
            if [ -f "$jar" ]; then
                CLASSPATH="$CLASSPATH:$jar"
            fi
        done
    fi

    echo "Using CLASSPATH: $CLASSPATH"

    # Javaファイルのコンパイル
    find src/main/java -name "*.java" -print0 | xargs -0 javac \
        -cp "$CLASSPATH" \
        -d build/classes \
        -encoding UTF-8 \
        -source 1.5 \
        -target 1.5

    # リソースファイルのコピー
    if [ -d "src/main/resources" ]; then
        cp -r src/main/resources/* build/classes/ 2>/dev/null || true
    fi

    echo "Compilation completed successfully."
}

# テストコンパイル
compile_tests() {
    echo "--- Compiling test sources ---"

    if [ ! -d "src/test/java" ]; then
        echo "No test directory found. Skipping test compilation."
        return 0
    fi

    if ! find src/test/java -name "*.java" | grep -q .; then
        echo "No test source files found."
        return 0
    fi

    # テスト用クラスパス
    TEST_CLASSPATH="build/classes"
    if [ -d "lib" ]; then
        for jar in lib/*.jar; do
            if [ -f "$jar" ]; then
                TEST_CLASSPATH="$TEST_CLASSPATH:$jar"
            fi
        done
    fi

    find src/test/java -name "*.java" -print0 | xargs -0 javac \
        -cp "$TEST_CLASSPATH" \
        -d build/test-classes \
        -encoding UTF-8 \
        -source 1.5 \
        -target 1.5

    echo "Test compilation completed."
}

# WARファイルの作成
create_war() {
    echo "--- Creating WAR file ---"

    if [ ! -d "src/main/webapp" ]; then
        echo "Warning: src/main/webapp directory not found."
        return 0
    fi

    # WEB-INF/classesにクラスファイルをコピー
    mkdir -p build/war/WEB-INF/classes
    if [ -d "build/classes" ]; then
        cp -r build/classes/* build/war/WEB-INF/classes/
    fi

    # webappの内容をコピー
    cp -r src/main/webapp/* build/war/

    # WARファイルの作成
    cd build/war
    jar cf ../../dist/app.war *
    cd ../..

    echo "WAR file created: dist/app.war"
}

# JavaDocの生成
generate_javadoc() {
    echo "--- Generating JavaDoc ---"

    if [ ! -d "src/main/java" ]; then
        echo "No source directory found. Skipping JavaDoc generation."
        return 0
    fi

    if ! find src/main/java -name "*.java" | grep -q .; then
        echo "No Java source files found."
        return 0
    fi

    mkdir -p docs/javadoc

    # ライブラリのクラスパス構築
    CLASSPATH="."
    if [ -d "lib" ]; then
        for jar in lib/*.jar; do
            if [ -f "$jar" ]; then
                CLASSPATH="$CLASSPATH:$jar"
            fi
        done
    fi

    find src/main/java -name "*.java" -print0 | xargs -0 javadoc \
        -d docs/javadoc \
        -cp "$CLASSPATH" \
        -encoding UTF-8 \
        -charset UTF-8 \
        -windowtitle "Legacy Application API" \
        -doctitle "Legacy Application API Documentation"

    echo "JavaDoc generated in docs/javadoc/"
}

# メイン処理
main() {
    case "${1:-build}" in
        "clean")
            clean
            ;;
        "compile")
            check_environment
            setup_directories
            compile
            ;;
        "test-compile")
            check_environment
            setup_directories
            compile
            compile_tests
            ;;
        "war")
            check_environment
            setup_directories
            compile
            create_war
            ;;
        "javadoc")
            check_environment
            generate_javadoc
            ;;
        "build"|"all")
            check_environment
            setup_directories
            clean
            compile
            compile_tests
            create_war
            generate_javadoc
            echo "=== Build completed successfully! ==="
            ;;
        "help"|"-h"|"--help")
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  build (default) - Full build (clean, compile, test-compile, war, javadoc)"
            echo "  clean          - Clean build artifacts"
            echo "  compile        - Compile main sources"
            echo "  test-compile   - Compile main and test sources"
            echo "  war            - Create WAR file"
            echo "  javadoc        - Generate JavaDoc"
            echo "  help           - Show this help"
            ;;
        *)
            echo "Unknown command: $1"
            echo "Use '$0 help' for usage information."
            exit 1
            ;;
    esac
}

main "$@"
