import fs from 'fs';
import path from 'path';

export default function handler(req, res) {
  const modsPath = path.join(process.cwd(), 'public/mods');
  const mods = fs.readdirSync(modsPath).filter((mod) => {
    const modPath = path.join(modsPath, mod);
    return fs.lstatSync(modPath).isDirectory();
  });

  res.status(200).json({ mods });
}
