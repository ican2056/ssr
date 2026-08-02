import subprocess

import modal


APP_NAME = "ssr"
IMAGE_NAME = "ican2056/ssr:latest"
PORT = 80

app = modal.App(APP_NAME)

image = (
    modal.Image.from_registry(
        IMAGE_NAME,
        add_python="3.11",
        setup_dockerfile_commands=[
            "USER root",
        ],
        force_build=True,
    )
    .entrypoint([])
)


@app.function(
    image=image,

    # 最低 0.25 个物理核心，最高 0.5 个物理核心
    cpu=(0.25, 0.5),

    # 内存固定为 512 MiB
    memory=(512, 512),

    # 无流量时缩容到 0
    min_containers=0,

    # 最多运行一个容器
    max_containers=1,

    # 空闲 60 秒后允许停止
    scaledown_window=600,

    # 单次容器调用最长 24 小时
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
