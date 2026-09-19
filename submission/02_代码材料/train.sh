#!/usr/bin/env bash
# 训练入口 · 香蕉皮2026
# 实际逻辑复用仓库内 experiments/lingbot_vla_v2_6b_robotwin/ 的脚本，这里只固定本次提交使用的超参。
set -euo pipefail

REPO_ROOT="${REPO_ROOT:-/RoboTwin}"
cd "$REPO_ROOT"

export PYTHONPATH="$REPO_ROOT/experiments/lingbot_vla_v2_6b_robotwin/source/lingbot-vla-v2:$REPO_ROOT"
export ROBOTWIN_DISABLE_CUROBO=1
export ROBOTWIN_EE_PLANNER=mplib
export PYOPENGL_PLATFORM=egl

# ---------------------------------------------------------------- 配置区
GPU_COUNT="${GPU_COUNT:-8}"                 # 4 或 8
MODE="${MODE:-full_sft}"                    # full_sft 或 lora
MAX_STEPS="${MAX_STEPS:-30000}"
SAVE_STEPS="${SAVE_STEPS:-1000}"
GLOBAL_BATCH="${GLOBAL_BATCH:-256}"
OPTIMIZER="${OPTIMIZER:-adamw}"

case "$GPU_COUNT" in
  4) HIP_VISIBLE_DEVICES="0,1,2,3"; MICRO_BATCH=16; ACCUM=4 ;;
  8) HIP_VISIBLE_DEVICES="0,1,2,3,4,5,6,7"; MICRO_BATCH=16; ACCUM=2 ;;
  *) echo "GPU_COUNT 只支持 4 或 8"; exit 1 ;;
esac
export HIP_VISIBLE_DEVICES
# --------------------------------------------------------------

echo "== 训练配置: mode=$MODE gpus=$GPU_COUNT steps=$MAX_STEPS global_batch=$GLOBAL_BATCH"

if [[ "$MODE" == "full_sft" ]]; then
  # 复现主路线：全参数 SFT，启用完整 depth/video teacher，FSDP2 full-shard
  FULL_SFT_STEPS="$MAX_STEPS" \
  FULL_SFT_SAVE_STEPS="$SAVE_STEPS" \
  FULL_SFT_GLOBAL_BATCH="$GLOBAL_BATCH" \
  FULL_SFT_OPTIMIZER="$OPTIMIZER" \
  FULL_SFT_MICRO_BATCH="$MICRO_BATCH" \
  FULL_SFT_ACCUM="$ACCUM" \
  bash experiments/lingbot_vla_v2_6b_robotwin/training/train_full_sft.sh
elif [[ "$MODE" == "lora" ]]; then
  TRAIN_STEPS="$MAX_STEPS" \
  bash experiments/lingbot_vla_v2_6b_robotwin/scripts/launch_lora_train.sh
else
  echo "未知 MODE: $MODE"; exit 1
fi
