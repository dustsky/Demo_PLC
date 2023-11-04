# 定义编译器和编译选项
CC = gcc
CFLAGS = -Wall -g

# 定义源文件和目标文件目录
SRC_DIR = src
OBJ_DIR = obj

# 获取源文件列表
SOURCES = $(wildcard $(SRC_DIR)/*.c)
# 生成目标文件列表，将每个.c文件的路径替换为.obj文件
OBJECTS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SOURCES))

# 定义目标可执行文件
TARGET = exe 

# 默认构建目标
all: $(TARGET)

# 生成可执行文件
$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^

# 编译每个C文件为目标文件
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# 创建目标文件目录
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# 清理生成的文件
clean:
	rm -f $(TARGET) $(OBJECTS)

.PHONY: all clean
