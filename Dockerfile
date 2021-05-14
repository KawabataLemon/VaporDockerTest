FROM vapor/swift:5.2 as build
WORKDIR /build

# フォルダごとコンテナないにコピー
COPY . .

# Swiftビルド
RUN swift build \
    --enable-test-discovery \
    -c release \
    -Xswiftc -g

# 実行環境向けにubuntuをとってくる
FROM vapor/ubuntu:18.04

WORKDIR /run

# ビルドの成果物を実行フォルダにうつす
COPY --from=build /build/.build/release /run

# swiftバイナリを持ってくる
COPY --from=build /usr/lib/swift/ /usr/lib/swift/

# 開放ポートを渡す
ARG PORT
ENV PORT $PORT

ENTRYPOINT ["./Run"]
CMD ["serve", "--env", "production", "--hostname", "0.0.0.0"]
