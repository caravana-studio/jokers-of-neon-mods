# Jokers of Neon Modding Tutorial

This guide will walk you through creating and uploading mods for **Jokers of Neon**.

---

## 1. Uploading Your Mod Resources

All mod resources must be uploaded to the following directory:  
`/public/mods/(MOD_NAME)/resources/`

Replace `(MOD_NAME)` with the name of your mod.

---

## 2. Creating a Mod Preview

Every mod requires a `config.json` file that contains basic information about the mod. The structure is as follows:

```json
{
  "name": "Nicon MOD",
  "description": "A test version of Jokers of Neon inspired by Balatro"
}
```

### Changing the Preview Image

To customize the mod's preview image upload an image named `thumbnail.png` to the same directory as `config.json`.

---

## 2. Adding or Modifying Cards

### Card ID structure

#### Traditional cards

0-12: Clubs (2 to Ace)
13-25: Diamonds (2 to Ace)
26-38: Hearts (2 to Ace)
39-51: Spades (2 to Ace)
52: Joker
53: Wildcard

#### Neon cards

200-212: Clubs (2 to Ace)
213-225: Diamonds (2 to Ace)
226-238: Hearts (2 to Ace)
239-251: Spades (2 to Ace)
252: Joker
253: Wildcard

#### Other cards

300-400: Special Cards
401-600: Rage Cards
601-700: Modifier Cards

### Updating or Adding Special Cards

To add or modify special cards, update the `specials.json` file. Use the following structure:

```json
{
  "CardID": {
    "name": "Card Name",
    "description": "Card Description"
  },
  "349": {
    "name": "Random Diamond Joker",
    "description": "Adds a number between -2 and 6 to the multiplier for each Diamonds-suited card played."
  },
  "355": {
    "name": "Extra",
    "description": "Demo"
  }
}
```

### Uploading Card Images

Place card images in the Cards folder. Images must follow the naming convention `CardID.png` to replace or add new card visuals.

For example:

`349.png`: Replaces or adds the image for Card ID 349.

## 4. Customizing Game Visuals

### Backgrounds

To change the game’s backgrounds, upload your images to the bg folder and replace the following files:

game-bg.jpg: Game background
home-bg.jpg: Home screen background
store-bg.jpg: Store screen background

### Borders

Modify the game’s borders by replacing these files:

bottom.png
bottom-rage.png
top.png
top-rage.png
