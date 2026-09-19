#!/usr/bin/env bash
# 生成赛事方要求的提交包：香蕉皮2026_初赛提交材料.zip
set -euo pipefail

TEAM_NAME="${TEAM_NAME:-香蕉皮2026}"
TEAM_ID="${TEAM_ID:-1380692}"
PKG_DIR="${TEAM_NAME}_初赛提交材料"

SUB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK_DIR="$(dirname "$SUB_DIR")"
STAGING="$SUB_DIR/_staging"

echo "== 队伍: $TEAM_NAME ($TEAM_ID)"

# 必需的顶层目录
REQUIRED_DIRS=(
  "01_评测结果"
  "02_代码材料"
  "03_模型权重"
  "04_复现与调优说明"
  "06_小红书创作活动"
)

missing=0
for d in "${REQUIRED_DIRS[@]}"; do
  if [[ ! -d "$SUB_DIR/$d" ]]; then
    echo "缺少目录: $d"
    missing=1
  fi
done

if [[ ! -f "$SUB_DIR/01_评测结果/results.json" ]]; then
  echo "缺少 01_评测结果/results.json"
  missing=1
fi

if [[ ! -f "$SUB_DIR/04_复现与调优说明/reproduction_report.md" ]]; then
  echo "缺少 04_复现与调优说明/reproduction_report.md"
  missing=1
fi

if [[ "$missing" -ne 0 ]]; then
  echo "必需材料不齐，终止打包。"
  exit 1
fi

# 校验 results.json：需覆盖 50 个任务、两个 setting
if command -v jq >/dev/null 2>&1; then
  n_tasks="$(jq '.tasks | length' "$SUB_DIR/01_评测结果/results.json")"
  n_clean="$(jq '.successes.clean | length' "$SUB_DIR/01_评测结果/results.json")"
  n_rand="$(jq '.successes.randomized | length' "$SUB_DIR/01_评测结果/results.json")"
  echo "== results.json: tasks=$n_tasks clean=$n_clean randomized=$n_rand"
  if [[ "$n_tasks" -ne 50 || "$n_clean" -ne 50 || "$n_rand" -ne 50 ]]; then
    echo "results.json 未覆盖 50 个任务 × 2 个 setting，请先补全。"
    exit 1
  fi
else
  echo "== 未找到 jq，跳过 results.json 结构校验"
fi

# 重新生成队伍信息，避免手改漏掉
mkdir -p "$STAGING/$PKG_DIR"

for item in "$SUB_DIR"/*; do
  base="$(basename "$item")"
  case "$base" in
    _staging|build_submission.sh|.gitignore|README.md) continue ;;
  esac
  cp -r "$item" "$STAGING/$PKG_DIR/"
done

cat > "$STAGING/$PKG_DIR/队伍信息.md" <<EOF
# 队伍信息

- 队伍名称：$TEAM_NAME
- 队伍 ID：$TEAM_ID
EOF

rm -f "$SUB_DIR/${PKG_DIR}.zip"
( cd "$STAGING" && zip -qr "$SUB_DIR/${PKG_DIR}.zip" "$PKG_DIR" )
rm -rf "$STAGING"

echo "== 完成: $SUB_DIR/${PKG_DIR}.zip"
ls -lh "$SUB_DIR/${PKG_DIR}.zip"
