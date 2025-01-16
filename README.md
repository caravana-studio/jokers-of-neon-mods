3 simples pasos

1. Deploy de los contratos del mod(especials y configurator_system)
```
make setup
```

2. Crear el mod en el mundo
```
make create-mod
```
<!-- 3. Registrar el configurator_system en el mundo -->
3. Registrar los especiales en el mod
```
make register-specials MOD_ID=1
```

4. Registrar los rages en el mod
```
make register-rages MOD_ID=1
```

ready to play! ✅


make deploy mod_id=name_mod


sozo execute mod_manager create_mod2 -c 1 --wait --world 

sozo execute mod_manager create_mod -c 0x1,1,0,0x1,0x1,0x1,0x1,0x1,0x1 --wait --world 0x065ce175b71709c8353b8575f190785b2b123590e9e90be4c4399257ce3ab709