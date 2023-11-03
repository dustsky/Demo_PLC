# 源文件目录
SOURCE_DIR = ./src

# 使用通配符匹配C源文件
SOURCES = $(wildcard $(SOURCE_DIR)/*.c)

# 构建的32位库和64位库
TARGET_32 = libMyLibrary32.dylib
TARGET_64 = libMyLibrary64.dylib

# 合并后的通用库
TARGET_UNIVERSAL = libMyLibrary.dylib

# 编译器和链接器设置
CC = clang
CFLAGS = -Wall -shared -fPIC
LDFLAGS =

# 构建规则
all: $(TARGET_UNIVERSAL)

$(TARGET_32): $(SOURCES) $(ASSETS)
	$(CC) $(CFLAGS) -arch armv7 -o $@ $(SOURCES) $(LDFLAGS)

$(TARGET_64): $(SOURCES) $(ASSETS)
	$(CC) $(CFLAGS) -arch arm64 -o $@ $(SOURCES) $(LDFLAGS)

$(TARGET_UNIVERSAL): $(TARGET_32) $(TARGET_64)
	lipo -create $(TARGET_32) $(TARGET_64) -output $@

# 编译资源文件并将其添加到库中
$(ASSETS): $(ASSETS)
	@for file in $(ASSETS); do \
		xxd -i $$file | sed 's/unsigned char/const char/' | sed 's/_len/_size/' > $$file.h; \
	done

# 清理构建
clean:
	rm -f $(TARGET_32) $(TARGET_64) $(TARGET_UNIVERSAL) $(ASSETS) $(ASSETS:.txt=.txt.h) $(ASSETS:.png=.png.h)

.PHONY: all clean
