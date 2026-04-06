# Telegram Setup

Telegram will be the first proactive notification channel for the personal AI system.

## Goal

Use Telegram to receive:

- morning student briefings
- deadline/risk alerts
- weekly review prompts
- later approval requests for selected actions

## What is included locally

- `~/.config/opencode/bin/send-telegram`
- `~/.config/opencode/bin/telegram-status`

These scripts rely on two environment variables:

- `TELEGRAM_BOT_TOKEN`
- `TELEGRAM_CHAT_ID`

## Step 1: Create the bot

1. Open Telegram and message `@BotFather`
2. Run `/newbot`
3. Pick a bot name
4. Pick a unique bot username ending in `bot`
5. Copy the bot token

## Step 2: Start a chat with your bot

1. Open your new bot
2. Press `Start`
3. Send at least one message to it

## Step 3: Get your chat ID

In a terminal, run:

```bash
export TELEGRAM_BOT_TOKEN="your-bot-token"
curl -fsS "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/getUpdates"
```

Look for a numeric `chat` -> `id` in the JSON. That is your `TELEGRAM_CHAT_ID`.

## Step 4: Save the secrets in your shell config

Add to your shell rc file:

```bash
export TELEGRAM_BOT_TOKEN="your-bot-token"
export TELEGRAM_CHAT_ID="your-chat-id"
```

Then reload your shell.

## Step 5: Verify the connection

```bash
~/.config/opencode/bin/telegram-status
~/.config/opencode/bin/send-telegram "OpenCode Telegram notifications are live."
```

## Planned automation use

After Telegram is connected, schedulers can call:

```bash
~/.config/opencode/bin/send-telegram "<message>"
```

That becomes the notification/output layer for the assistant.

## Safety model

- summaries and reminders can be sent automatically
- approval requests can be sent later
- risky tool actions should still remain approval-gated
