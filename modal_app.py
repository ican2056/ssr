import subprocess
import modal

APP_NAME = "ssr"
IMAGE_NAME = "ican2056/ssr:latest"
PORT = 80

app = modal.App(APP_NAME)

image = (
    modal.Image.from_registry(
        IMAGE_NAME,

        # 为 Modal Function 注入 Python 运行环境
        add_python="3.11",

        # 对应原 Dockerfile 中的 USER root
        setup_dockerfile_commands=[
            "USER root",
        ],

        # latest 标签每次部署时重新检查和构建
        force_build=True,
    )

    # 清除原始镜像可能自带的 ENTRYPOINT
    .entrypoint([])
)


@app.function(
    image=image,

    # 最低 0.25 个物理核心，最高限制为 0.5 个物理核心
    cpu=(0.25, 0.5),

    # 固定为 512 MiB，超过后会触发 OOM
    memory=(512, 512),

    # 无流量时允许缩容到 0
    min_containers=0,

    # 最多只启动一个实例，防止并行实例额外消耗额度
    max_containers=1,

    # 空闲 1200 秒后允许停止
    scaledown_window=1200,

    # 单次请求或 WebSocket 连接最长 24 小时
    timeout=86400,
)
@modal.concurrent(max_inputs=100)
@modal.web_server(
    port=PORT,
    startup_timeout=120,
)
def serve():
    process = subprocess.Popen(
        ["/bin/bash", "./start.sh"],
        cwd="/app",
    )

    print(f"start.sh started, pid={process.pid}")
