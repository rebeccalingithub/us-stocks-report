#!/bin/bash

# 美股报告看板 - 自动同步到 GitHub 脚本（Windows 版 v2.2）
# 路径：C:/Users/rebeccalin/Desktop/美股报告看板

REPO_DIR="C:/Users/rebeccalin/Desktop/美股报告看板"
DAILY_SRC="C:/Users/rebeccalin/Desktop/美股大盘看板/latest-daily-report.html"

# 把大盘看板的 HTML 同步进来
if [ -f "$DAILY_SRC" ]; then
    cp "$DAILY_SRC" "$REPO_DIR/latest-daily-report.html"
fi

cd "$REPO_DIR"

# 添加三份报告 + index
git add latest-daily-report.html latest-invest-report.html latest-trump-report.html index.html

# 无改动则跳过
if git diff --cached --quiet; then
    echo "No changes to commit."
    exit 0
fi

# 提交（带时间戳）
git commit -m "更新报告: $(date '+%Y-%m-%d %H:%M:%S')"

# 推送到 GitHub
git push origin main

echo "Report synced to GitHub."

# 部署到 Vercel（生产环境）
echo "Deploying to Vercel..."
npx vercel --prod --yes
echo "Vercel deploy done."
