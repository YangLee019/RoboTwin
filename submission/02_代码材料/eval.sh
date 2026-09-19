#!/usr/bin/env bash
# 评测入口 · 香蕉皮2026
# 闭环评测：RoboTwin 2.0 / Aloha-AgileX，clean + randomized
set -euo pipefail

REPO_ROOT="${REPO_ROOT:-/RoboTwin}"
cd "$REPO_ROOT"

export PYTHONPATH="$REPO_ROOT/experiments/lingbot_vla_v2_6b_robotwin/source/lingbot-vla-v2:$REPO_ROOT"
export ROBOTWIN_DISABLE_CUROBO=1
export ROBOTWIN_EE_PLANNER=mplib
export PYOPENGL_PLATFORM=egl

# ---------------------------------------------------------------- 配置区
GPU_COUNT="${GPU_COUNT:-8}"                 # 4 或 8
RUN_NAME="${RUN_NAME:-bananapeel2026_full_sft}"
CHECKPOINT="${CHECKPOINT:-<填写待评测的 checkpoint 路径>}"
OUT_ROOT="${OUT_ROOT:-/workspace/runtime/outputs}"
VIDEO="${VIDEO:-0}"                         # 1 生成 mp4，0 关闭
# --------------------------------------------------------------

video_flag="--no-video"
[[ "$VIDEO" == "1" ]] && video_flag="--video"

echo "== 评测: gpus=$GPU_COUNT run=$RUN_NAME checkpoint=$CHECKPOINT"

# 启动前清理占用 13400 的旧服务
pkill -f 'launch_official_server' 2>/dev/null || true

python experiments/lingbot_vla_v2_6b_robotwin/scripts/run_clean_benchmark.py \
  --checkpoint "$CHECKPOINT" \
  --gpu-count "$GPU_COUNT" \
  --run-name "$RUN_NAME" \
  --out-root "$OUT_ROOT" \
  "$video_flag"

echo "== 完成，结果目录: $OUT_ROOT/$RUN_NAME"
echo "== 用 --resume 可跳过已有完成标记的任务"
