# Check Mail Skill

检查 CUHK 和 Google 邮箱最近 14 天的邮件，提取待办事项并以中文格式输出。

## 执行步骤

### 1. 获取当前时间

使用 bash 命令获取香港时间：
```bash
date
```

### 2. 获取邮件内容

**关键原则：**
- 使用 `every message` 然后按日期筛选（不要用 `messages 1 thru 10`，会报错）
- 设置 timeout=30000ms（邮件量大需要更长时间）
- 限制每个账户最多 20 封邮件防止超时
- Google 账户用 `mailbox "INBOX"`（大写）
- CUHK 账户用 `mailbox "Inbox"`（首字母大写）

使用以下 AppleScript 代码：

```applescript
set twoWeeksAgo to (current date) - (14 * days)
set output to ""
set emailCount to 0
set maxEmails to 20

tell application "Mail"
    -- Check Google account
    try
        set googleAccount to account "Google"
        set googleInbox to mailbox "INBOX" of googleAccount
        set allMessages to every message of googleInbox

        set output to output & "=== GOOGLE ACCOUNT ===" & return

        repeat with aMessage in allMessages
            try
                set msgDate to date received of aMessage
                if msgDate > twoWeeksAgo then
                    set msgSubject to subject of aMessage
                    set msgSender to sender of aMessage
                    set msgContent to content of aMessage
                    set msgRead to read status of aMessage

                    if msgRead is false then
                        set output to output & "[未读] " & msgSubject & return
                    else
                        set output to output & "[已读] " & msgSubject & return
                    end if
                    set output to output & "发件人: " & msgSender & return
                    set output to output & "时间: " & msgDate & return

                    if length of msgContent > 1000 then
                        set msgContent to text 1 thru 1000 of msgContent & "..."
                    end if
                    set output to output & "内容: " & msgContent & return & return & "---" & return & return

                    set emailCount to emailCount + 1
                    if emailCount >= maxEmails then exit repeat
                end if
            end try
        end repeat
    on error errMsg
        set output to output & "Google account error: " & errMsg & return & return
    end try

    -- Check CUHK account
    set emailCount to 0
    try
        set cuhkAccount to account "CUHK"
        set cuhkInbox to mailbox "Inbox" of cuhkAccount
        set allMessages to every message of cuhkInbox

        set output to output & return & "=== CUHK ACCOUNT ===" & return

        repeat with aMessage in allMessages
            try
                set msgDate to date received of aMessage
                if msgDate > twoWeeksAgo then
                    set msgSubject to subject of aMessage
                    set msgSender to sender of aMessage
                    set msgContent to content of aMessage
                    set msgRead to read status of aMessage

                    if msgRead is false then
                        set output to output & "[未读] " & msgSubject & return
                    else
                        set output to output & "[已读] " & msgSubject & return
                    end if
                    set output to output & "发件人: " & msgSender & return
                    set output to output & "时间: " & msgDate & return

                    if length of msgContent > 1000 then
                        set msgContent to text 1 thru 1000 of msgContent & "..."
                    end if
                    set output to output & "内容: " & msgContent & return & return & "---" & return & return

                    set emailCount to emailCount + 1
                    if emailCount >= maxEmails then exit repeat
                end if
            end try
        end repeat
    on error errMsg
        set output to output & "CUHK account error: " & errMsg & return
    end try
end tell

return output
```

**重要：设置 timeout 参数为 30000**

### 3. 分析待办事项

搜索英文关键词（邮件主要是英文）：

**Action indicators:**
- TODO, To Do, Action Item, Action Required
- URGENT, ASAP, deadline, due date
- please, kindly, request, invite
- contact, send, submit, prepare, complete
- follow up, respond, reply, provide, confirm
- review, revise, check, verify

**Chinese keywords:**
- 请, 需要, 提交, 完成, 准备, 截止, 期限
- 审稿, review, invitation

**格式识别：**
- `- [ ]`, `* [ ]`, numbered lists `1.`, bullet points `•`
- "Please...", "Could you...", "Need to..."
- "You are invited...", "Reminder..."

### 4. 格式化输出

使用中文格式输出：

```
📧 邮件检查结果 ([当前 HKT 时间])

发现最近 14 天内 X 封邮件，Y 个待办事项

---

📌 [邮件主题]
👤 发件人：[姓名/邮箱]
📅 时间：[接收时间]

📋 待办事项：
- [ ] 任务1
- [ ] 任务2

---

📌 [下一封邮件...]
```

**如果找到具体待办事项：** 列出任务清单

**如果没找到明确待办：** 列出邮件摘要供参考

## 常见陷阱

1. **不要用** `messages 1 thru 10` - 会导致错误
2. **不要用** `search mailboxes for` - 语法复杂易出错
3. **必须区分** INBOX (Google) vs Inbox (CUHK) 大小写
4. **必须设置** timeout=30000 - 邮件量大需要时间
5. **限制数量** - 每个账户最多 20 封邮件防止超时
6. **英文搜索** - 邮件主要是英文，用英文关键词提取待办
