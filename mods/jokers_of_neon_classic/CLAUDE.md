# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the "Jokers of Neon Classic" mod for the Jokers of Neon game, built with Cairo and Dojo framework. It's a blockchain-based poker game mod that implements special cards, rage mechanics, and a complex scoring system.

## Development Commands

### Build and Compilation
- `scarb build` - Build the Cairo project using Scarb package manager
- `scarb fmt` - Format Cairo code according to project standards (max line length: 120)

### Development Tools
- `make katana` - Start local Katana node for development with CORS enabled and 2.5s block time
- `make setup` - Run initial project setup (requires setup script)
- `make create-mod` - Create a new mod (requires create_mod script)
- `make register-specials MOD_ID=<id>` - Register special cards for a given mod ID
- `make register-rages MOD_ID=<id>` - Register rage cards for a given mod ID
- `make deploy-slot PROFILE=<profile> ACTION=<action>` - Deploy slot configuration

### Configuration
- Development environment uses local RPC at `http://localhost:5050/`
- Default namespace: `jokers_of_neon_classic`
- Cairo version: 2.12.2

## Architecture

### Core Structure
The project follows a modular Cairo architecture with these main components:

- **Configs**: Game configuration (game rules, shop prices, scoring)
- **Specials**: Special card implementations with different trigger types:
  - `play/` - Triggered during play phase
  - `hit/` - Triggered on specific card hits
  - `hand/` - Triggered based on hand composition
  - `converter/` - Card transformation effects
  - `discard/` - Triggered during discard phase
  - `game/` - Game-wide effects
  - `lose/` - Triggered on loss conditions
  - `power_up/` - Power-up related effects

- **Rages**: Negative effect cards with categories:
  - `debuff/` - General debuff effects
  - `game/` - Game mechanic modifications
  - `round/` - Round-specific effects
  - `silence/` - Card silencing effects

- **Utils**: Information providers and utility functions

### Card System
Cards are organized by numeric IDs:
- Specials: 10000+ (e.g., SPECIAL_MULTI_FOR_HEART_ID = 10000)
- Rages: 20000+ (e.g., RAGE_CARD_SILENT_HEARTS = 20001)

Cards are categorized by rarity grades (C, B, A, S) with different probabilities, costs, and reward levels.

### Dojo Integration
This is a Dojo world contract that implements:
- Contract interfaces from `jokers_of_neon_lib`
- External contract dependencies for world and nonce management
- Resource-based architecture with writers configuration

### Game Configuration
Key game parameters are defined in `src/configs/game.cairo`:
- Starting conditions: 5 plays, 5 discards, 8-card hand
- Progressive pricing for slots and burns
- Complex round scoring system with exponential growth
- Rage system with probability increases per round

## Key Dependencies
- **Dojo**: v1.7.0 (blockchain game framework)
- **jokers_of_neon_lib**: Core game library (develop branch)
- Cairo 2.12.2 with sierra-replace-ids enabled

## Testing
No specific test commands found in the configuration. Check for test files in the codebase or consult project maintainers for testing procedures.