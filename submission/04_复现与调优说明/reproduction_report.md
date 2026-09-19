# 复现与调优说明 · 香蕉皮2026

> 队伍 ID：1380692

## 1. 方案概述

- 基座模型：`robbyant/lingbot-vla-v2-6b`（官方基础 checkpoint，训练起点）
- 训练数据：RoboTwin 2.0 Aloha-AgileX 50 个任务的 clean 数据，每任务 50 条
- 运行平台：AMD Radeon Cloud，W7900 48GB，ROCm 7.2.1 + PyTorch 2.9.1
- 评测口径：50 个任务 × 100 episodes，clean 与 randomized 两个 setting

## 2. 环境与版本

| 组件 | 版本 / 提交 |
| --- | --- |
| 基础镜像 | `rocm/pytorch:rocm7.2.1_ubuntu24.04_py3.12_pytorch_release_2.9.1` |
| RoboTwin | `266f3aadf505a4f7fe9af0faa41a20f5f47cd123` |
| XPolicyLab | `c37109c500be67d0dea6b36bf7337bbd26e763cd` |
| LingBot-VLA-v2 | `951475ae1b1d87553e7dc47c97b53a3d695c0d13` |
| 官方基础模型 revision | `11c703bf6a5c1f45b3b69168482da11fdbba53d7` |
| RoboTwin 2.0 数据 revision | `a967b852afa21a9cbf19a198f7e653109042e87c` |
| PyTorch / ROCm / LeRobot | 2.9.1 / 7.2.1 / 0.6.0 |

AMD 环境下关闭 CuRobo，使用 MPLib 做末端位姿规划，评测启用 `expert_check=true`。

## 3. 训练方式

### 3.1 训练配置

| 项目 | 取值 |
| --- | --- |
| 训练方式 | 待填写（全参数 SFT / LoRA） |
| GPU 数量 | 待填写（4 / 8） |
| micro batch / GPU | 待填写 |
| 梯度累积 | 待填写 |
| 全局 batch | 待填写 |
| 优化器 | AdamW |
| 并行策略 | FSDP2，`enable_full_shard=True` |
| 训练步数 | 待填写 |
| checkpoint 间隔 | 待填写 |

### 3.2 训练命令

见 `02_代码材料/train.sh`。

### 3.3 训练过程中的关键现象

- 稳态 StepTime：待填写
- 峰值显存/GPU：待填写
- 遇到的问题与处理：待填写

## 4. 模型改动

| 文件 | 改动说明 |
| --- | --- |
| `envs/robot/planner.py` | 待填写 |
| `envs/robot/robot.py` | 待填写 |
| `envs/_base_task.py` | 待填写 |
| `scripts/eval_policy_xpolicylab.py` | 待填写 |
| 其他 | 待填写 |

## 5. 调优思路

待填写：说明尝试过哪些方向、各自的闭环表现、最终选择该配置的原因。

## 6. 评测方式

- 命令：见 `02_代码材料/eval.sh`
- 单任务冒烟：`adjust_bottle` 10 episodes，用于验证模型服务与评测链路
- 全量评测：clean + randomized，每任务 100 次
- 结果文件：`01_评测结果/results.json`

### 6.1 实测耗时

| 配置 | 规模 | 墙钟 |
| --- | --- | --- |
| 待填写 | 待填写 | 待填写 |

## 7. 复现步骤

1. 申请 AMD Radeon Cloud 实例：4 或 8 × W7900，镜像选 `robotwin`，资源池 `Dev`，Workspace Storage 选 `Persistent /workspace`，Mount a model 选 `Devzone`。
2. 确认 `/models/robotwin-persistent` 已挂载，且 `assets`、`data`、`models` 软链接就位。
3. 检出本仓库 `contest/bananapeel2026` 分支的对应提交。
4. 按 `02_代码材料/train.sh` 复现训练，产物写入 `/workspace/runtime`。
5. 按 `02_代码材料/eval.sh` 复现评测，得到 `results.json`。

## 8. 已知问题与限制

- 待填写

## 9. 结果摘要

| setting | 成功次数 / 总次数 | 成功率 |
| --- | --- | --- |
| clean | 待填写 | 待填写 |
| randomized | 待填写 | 待填写 |
