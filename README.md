# Fly GUI System

A configurable Fly GUI system for FiveM servers using ESX.

## Features

- Toggle flight on/off
- Adjust flight speed
- Persistent settings saved to database

## Requirements

- FiveM server
- ESX framework
- MySQL database

## Installation

1. Download the latest release from the [releases page](https://github.com/EnderDevelopment/fly-gui-system/releases).
2. Extract the contents into your FiveM server's `resources` directory.
3. Add `start fly-gui-system` to your server.cfg file.
4. Run the SQL script provided in the `database.sql` file to create the necessary database table.

## Usage

- Players can open the Fly GUI by typing `/flygui` in the chat.
- Use the menu to toggle flight and adjust flight speed.

## Configuration

The configuration is done in the `config.lua` file. You can adjust the default flight speed and database settings.

```lua
Config = {}

-- Fly GUI settings
Config.FlySpeed = 1.0
Config.FlyEnabled = false

-- Database settings
Config.DatabaseName = 'fivem'
Config.DatabaseTable = 'fly_system'
```

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=fly-gui-system&utm_content=bottom) — describe it in one sentence and get the full source code.