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

## 3. Adding or Modifying Cards

### Card ID structure
<table>
  <tr>
    <th>Category</th>
    <th>Range</th>
    <th>Details</th>
  </tr>
  <tr>
    <td rowspan="6">Traditional Cards</td>
    <td>0-12</td>
    <td>Clubs (2 to Ace)</td>
  </tr>
  <tr>
    <td>13-25</td>
    <td>Diamonds (2 to Ace)</td>
  </tr>
  <tr>
    <td>26-38</td>
    <td>Hearts (2 to Ace)</td>
  </tr>
  <tr>
    <td>39-51</td>
    <td>Spades (2 to Ace)</td>
  </tr>
  <tr>
    <td>52</td>
    <td>Joker</td>
  </tr>
  <tr>
    <td>53</td>
    <td>Wildcard</td>
  </tr>
  <tr>
    <td rowspan="6">Neon Cards</td>
    <td>200-212</td>
    <td>Clubs (2 to Ace)</td>
  </tr>
  <tr>
    <td>213-225</td>
    <td>Diamonds (2 to Ace)</td>
  </tr>
  <tr>
    <td>226-238</td>
    <td>Hearts (2 to Ace)</td>
  </tr>
  <tr>
    <td>239-251</td>
    <td>Spades (2 to Ace)</td>
  </tr>
  <tr>
    <td>252</td>
    <td>Joker</td>
  </tr>
  <tr>
    <td>253</td>
    <td>Wildcard</td>
  </tr>
  <tr>
    <td rowspan="3">Other Cards</td>
    <td>300-400</td>
    <td>Special Cards</td>
  </tr>
  <tr>
    <td>401-600</td>
    <td>Rage Cards</td>
  </tr>
  <tr>
    <td>601-700</td>
    <td>Modifier Cards</td>
  </tr>
</table>




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

> For example:
`349.png`: Replaces or adds the image for Card ID 349.

<img width="113" alt="Screenshot 2025-01-19 at 4 08 07 PM" src="https://github.com/user-attachments/assets/4e8cc1de-c9c2-4313-8d7e-2d7927e89862" />


## 4. Customizing Game Visuals

### Backgrounds

To change the game’s backgrounds, upload your images to the `bg` folder and replace the following files:

- `game-bg.jpg`: Game background
- `home-bg.jpg`: Home screen background
- `store-bg.jpg`: Store screen background

### Borders

Modify the game’s borders by replacing these files:

- `bottom.png`
- `bottom-rage.png`
- `top.png`
- `top-rage.png`

# Result example
![image](https://github.com/user-attachments/assets/387dc72c-974d-4cc3-b230-45f62db79a66)

