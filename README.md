# ESX DM Command System

A simple and effective **direct messaging system** for team members in a FiveM server using **ESX**.  
Supports **role-based permissions**, **custom notifications**, and **Discord webhook logging**.

## Features

- `/dm <id> <message>` command to send private messages between staff and players
- Role-restricted access: only specific groups can use the command
- Custom notification system for sender and receiver
- Sends logs to a **Discord webhook** with message details and timestamp
- Configurable **group colors** for styled messages

## Role Configuration

The following groups are allowed to use the `/dm` command (configured in `groupSettings`):

| Group     | Color     |
|-----------|-----------|
| leitung   | Red       |
| suadmin   | Orange    |
| admin     | Gold      |
| dev       | Blue      |
| mod       | Pink      |

## Events

### `kilian:dm:showNotification`

- Sent to the target player
- Parameters: `color`, `message`

### `notifications`

- Sent to sender and target for feedback
- Requires a custom notification handler compatible with:
  ```lua
  TriggerClientEvent("notifications", playerId, color, title, message, timeout)

## Author
Created by **Kilian**
